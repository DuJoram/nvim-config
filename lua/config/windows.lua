local M = {}

local function has_neighbor(win, dir)
  local neighbor = vim.api.nvim_win_call(win, function()
    vim.cmd.wincmd(({
      left = "h",
      right = "l",
      up = "k",
      down = "j",
    })[dir])
    return vim.api.nvim_get_current_win()
  end)

  local neigh_id = vim.api.nvim_win_get_number(neighbor)
  local win_id = vim.api.nvim_win_get_number(win)
  return neigh_id ~= win_id
end
