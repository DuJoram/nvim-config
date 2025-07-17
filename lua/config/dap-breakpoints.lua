local M = {}
local dap = require("dap")

local session_dir = vim.fs.joinpath(vim.fn.stdpath("state"), "sessions")

local function get_breakpoint_path()
  local cwd = vim.fn.getcwd()
  -- dirname as id
  local session_file = vim.fn.fnamemodify(cwd, ":p:h:t")
  return vim.fs.joinpath(session_dir, session_file .. ".dap_breakpoints.json")
end

function M.save_breakpoints()
  local breakpoints = require("dap.breakpoints").get()
  local file = io.open(get_breakpoint_path(), "w")
  if file then
    file:write(vim.fn.json_encode(breakpoints))
    file:close()
  end
end

function M.load_breakpoints()
  local file = io.open(get_breakpoint_path(), "r")
  if not file then
    return
  end
  local content = file:read("*a")
  file:close()
  local breakpoints = vim.fn.json_decode(content)
  if breakpoints then
    for bufname, bps in pairs(breakpoints) do
      for _, bp in ipairs(bps) do
        dap.set_breakpoint(bp.file, bp.line, bp.condition)
      end
    end
  end
end

function M.clear_breakpoints()
  require("dap.breakpoints").clear()
end

return M
