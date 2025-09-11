return {
  "chomosuke/typst-preview.nvim",
  ft = "typst",
  version = "1.*",
  opts = {
    get_main_file = require("config.util").typst_find_main,
  },
}
