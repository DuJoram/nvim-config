return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",

  depndencies = { "nvim-lua/plenary.nvim" },

  wk_groups = { "<leader>f", desc = "Find" },

  keys = {
    { "<leader>f", desc = "Find" },
    { "<leader><space>", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
    { "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Find Files (Git)" },
    { "<leader>fG", "<cmd>Telescope live_grep<cr>", desc = "Live Grep (Root)" },
    { "<leader>ft", "<cmd>Telescope tags<cr>", desc = "Find Tags (ctags)" },
    { "<leader>fq", "<cmd>Telescope quickfix<cr>", desc = "Quickfix" },
    { "<leader>fb", desc = "Buffer Searches" },
    { "<leader>fbb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
    { "<leader>fbf", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Fuzzy search" },
    { "<leader>fbt", "<cmd>Telescope current_buffer_tags<cr>", desc = "Tags" },
    { "<leader>fd", "<cmd>Telescope lsp_definitions<cr>", desc = "LSP Definitions" },
    { "<leader>fr", "<cmd>Telescope lsp_references<cr>", desc = "LSP References" },
    { "<leader>fsw", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "LSP Workspace Symbols" },
    { "<leader>fsd", "<cmd>Telescope lsp_document_symbols<cr>", desc = "LSP Document Symbols" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "NeoVim Help Tags" },
  },
}
