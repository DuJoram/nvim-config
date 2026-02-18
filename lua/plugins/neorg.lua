return {
  "nvim-neorg/neorg",
  dependencies = {
    -- "3rd/image.nvim",
    -- "nvim-lua/plenary.nvim",
    -- "nvim-neorg/lua-utils.nvim",
    -- "nvim-neotest/nvim-nio",
  },
  lazy = false,
  version = "*",
  config = function(_, opts)
    require("neorg").setup(opts)
    vim.wo.foldlevel = 99
    vim.wo.conceallevel = 2
  end,
  opts = {
    load = {
      ["core.defaults"] = {},
      ["core.concealer"] = {},
      ["core.latex.renderer"] = {},
      -- ["core.integrations.image"] = {
      --   conceal = true,
      --   render_on_enter = true,
      -- },
      ["core.dirman"] = {
        config = {
          workspaces = {
            notes = "~/Documents/neorg/",
          },
          default_workspace = "notes",
        },
      },
    },
  },
}
