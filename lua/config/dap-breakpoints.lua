local M = {}

local session_dir = vim.fs.joinpath(vim.fn.stdpath("state"), "sessions")

function M.save_breakpoints()
  local breakpoints = require("dap.breakpoints").get()
  vim.notify(vim.inspect(breakpoints))
  vim.notify(vim.inspect(#breakpoints))
  if vim.tbl_count(breakpoints) == 0 then
    vim.notify("No breakpoints")
    return
  end
  local file = io.open(M.get_breakpoint_path(), "w")
  if file then
    local breakpoints_by_file = {}
    for bufnr, bps in pairs(breakpoints) do
      breakpoints_by_file[vim.api.nvim_buf_get_name(bufnr)] = bps
    end

    local bpsj = vim.fn.json_encode(breakpoints_by_file)
    vim.notify(bpsj)
    file:write(vim.fn.json_encode(breakpoints_by_file))
    file:close()
  end
end

function M.load_breakpoints()
  local file = io.open(M.get_breakpoint_path(), "r")
  if not file then
    return
  end
  local content = file:read("*a")
  local breakpoints_by_file = vim.fn.json_decode(content)
  local dapbp = require("dap.breakpoints")
  file:close()
  for fname, breakpoints in pairs(breakpoints_by_file) do
    local bufnr = vim.fn.bufnr(fname, true)
    if vim.fn.bufloaded(bufnr) == 0 then
      vim.api.nvim_buf_call(bufnr, vim.cmd.edit)
    end
    for _, bp in pairs(breakpoints) do
      dapbp.set(
        { condition = bp.condition, log_message = bp.logMessage, hit_condition = bp.hitCondition },
        bufnr,
        bp.line
      )
    end
  end
end

function M.clear_breakpoints()
  require("dap.breakpoints").clear()
end

function M.get_breakpoint_path(opts)
  opts = opts or {}
  local name = vim.fn.getcwd():gsub("[\\/:]+", "%%")
  vim.notify(name)
  return vim.fs.joinpath(session_dir, name .. ".breakpoints.json")
end

function M.setup()
  vim.api.nvim_create_user_command("DapBreakpointsLoad", function()
    vim.notify("Loading breakpoints")
    M.load_breakpoints()
  end, { desc = "Load dap breakpoints from session" })

  vim.api.nvim_create_user_command("DapBreakpointsSave", function()
    vim.notify("Saving breakpoints")
    M.save_breakpoints()
    vim.wait(1000, function() end)
  end, { desc = "Save dap breakpoints from session" })

  vim.api.nvim_create_augroup("DapBreakpointsSession", {})

  vim.api.nvim_create_autocmd("SessionLoadPost", {
    group = "DapBreakpointsSession",
    desc = "Load breakpoints from session",
    command = "DapBreakpointsLoad",
  })

  vim.api.nvim_create_autocmd("SessionWritePost", {
    pattern = "PersistenceSavePost",
    desc = "Save breakpoints from session",
    command = "DapBreakpointsSave",
  })
end

return M
