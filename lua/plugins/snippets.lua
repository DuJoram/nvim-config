return {
  "L3MON4D3/LuaSnip",
  build = (not jit.os:find("Windows"))
      and "echo -e 'NOTE: jsregexp is optional, so not a big deal if it fails to build\n'; make install_jsregexp"
    or nil,
  -- stylua: ignore
  opts = function()
    local types = require("luasnip.util.types")
    local opts = {
      update_events = "TextChanged,TextChangedI",
      -- delete_check_events = "TextChanged",
      -- ext_opts = {
      --   [types.insertNode] = {
      --     active = {
      --       virt_text = { { "●", "GruvboxBlue" } }
      --     },
      --   },
      --   [types.choiceNode] = {
      --     active = {
      --       -- virt_text = { { "choiceNode", "Comment" } },
      --       virt_text = { { "●", "GruvboxOrange" } }
      --     },
      --   },
      -- },
      ext_base_prio = 300,
      ext_prio_increase = 1,
      enable_autosnippets = true,
      cut_selection_keys = "<Tab>",
    }
    return opts
  end,
  config = function(_, popts)
    require("luasnip").setup(popts)

    require("luasnip.loaders.from_lua").load({ paths = vim.fn.stdpath("config") .. "/luasnips/" })
    vim.api.nvim_create_user_command("LuaSnipEdit", function()
      require("luasnip.loaders").edit_snippet_files()
    end, { nargs = 0 })
  end,
}
