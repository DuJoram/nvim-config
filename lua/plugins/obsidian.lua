return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {

    workspaces = {
      {
        name = "Org",
        path = "~/Documents/org",
      },
      {
        name = "ZK",
        path = "~/Documents/ZK",
      },
    },
  },
}
