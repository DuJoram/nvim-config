local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  checker = { enable = true },
  rocks = { enabled = false },
})

-- This "extends" lazy to allow adding the 'wk_groups' key to plugin configurations.
-- If present, they will be passed to which-key. This is useful for setting groups
-- without needing the plugin to be loaded. Otherwise, some entries in the which-key
-- menu will be without names until the plugin is first loaded. While this could be
-- configured somewhere locally, I prefer each plugin to set up its groups locally.
local plugins = require("lazy").plugins()
for _, plugin in pairs(plugins) do
  local wk = require("which-key")
  if plugin["wk_groups"] then
    wk.add(plugin.wk_groups)
  end
end
