return {
  {
    "lukas-reineke/headlines.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = true, -- or `opts = {}`
  },
}
-- return {
--   "MeanderingProgrammer/render-markdown.nvim",
--   opts = {
--     code = {
--       sign = false,
--       width = "block",
--       right_pad = 1,
--     },
--     heading = {
--       sign = false,
--       icons = {},
--     },
--     checkbox = {
--       enabled = false,
--     },
--     latex = {
--       enabled = true,
--       render_modes = false,
--       converter = "latex2text",
--       highlight = "RenderMarkdownamath",
--       top_pad = 0,
--       bottom_pad = 0,
--     },
--   },
--   ft = { "markdown", "norg", "rmd", "org", "codecompanion" },
-- }
