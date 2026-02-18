return {
  {
    "stevearc/oil.nvim",

    dependencies = {
      "nvim-mini/mini.icons",
      -- "nvim-tree/nvim-web-devicons",
    },
    lazy = false,
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      default_file_explorer = true,
      columns = {
        "icon",
        "permissions",
        "size",
        "mtime",
      },
      buf_options = {
        buflisted = false,
        bufhidden = "hide",
      },
      win_options = {
        wrap = false,
        signcolumn = "no",
        cursorcolumn = false,
        foldcolumn = "0",
        spell = false,
        list = false,
        conceallevel = 3,
        concealcursor = "nvic",
      },

      delete_to_trash = false,
      skip_confirm_for_simple_edits = false,
      prompt_save_on_select_new_entry = true,
      cleanup_delay_ms = 2000,
      lsp_file_methods = {
        enabled = true,
        timeout_ms = 1000,
        autosave_changes = false,
      },

      keymaps = {
        ["gd"] = {
          desc = "Toggle file detail view",
          callback = function()
            require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
          end,
        },
        ["g?"] = { "actions.show_help", mode = "n" },
        ["<CR>"] = "actions.select",
        ["<C-s>"] = { "actions.select", opts = { vertical = true } },
        ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
        ["<C-t>"] = { "actions.select", opts = { tab = true } },
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = { "actions.close", mode = "n" },
        ["<C-l>"] = "actions.refresh",
        ["-"] = { "actions.parent", mode = "n" },
        ["_"] = { "actions.open_cwd", mode = "n" },
        ["`"] = { "actions.cd", mode = "n" },
        ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
        ["gs"] = { "actions.change_sort", mode = "n" },
        ["gx"] = "actions.open_external",
        ["g."] = { "actions.toggle_hidden", mode = "n" },
        ["g\\"] = { "actions.toggle_trash", mode = "n" },
      },
      view_options = {
        show_hidden = true,
        is_hidden_file = function(name, bufnr)
          local m = name:match("^%. ")
          return m ~= nil
        end,

        is_always_hidden = function(name, bufnr)
          return false
        end,

        natural_order = false,
        case_insensitive = false,
        sort = {
          { "type", "asc" },
          { "name", "asc" },
        },

        highlight_filename = function(entry, is_hidden, is_link_target, is_link_orphan)
          return nil
        end,
      },

      exta_scp_args = {},
      float = {
        padding = 2,
        max_width = 0,
        max_height = 0,
        border = nil,
        win_options = {
          winblend = 0,
        },
        preview_split = "auto",
        override = function(conf)
          return conf
        end,
      },
      preview_win = {
        -- Whether the preview window is automatically updated when the cursor is moved
        update_on_cursor_moved = true,
        -- How to open the preview window "load"|"scratch"|"fast_scratch"
        preview_method = "fast_scratch",
        -- A function that returns true to disable preview on a file e.g. to avoid lag
        disable_preview = function(filename)
          return false
        end,
        -- Window-local options to use for preview window buffers
        win_options = {},
      },
      -- Configuration for the floating action confirmation window
      confirmation = {
        -- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
        -- min_width and max_width can be a single value or a list of mixed integer/float types.
        -- max_width = {100, 0.8} means "the lesser of 100 columns or 80% of total"
        max_width = 0.9,
        -- min_width = {40, 0.4} means "the greater of 40 columns or 40% of total"
        min_width = { 40, 0.4 },
        -- optionally define an integer/float for the exact width of the preview window
        width = nil,
        -- Height dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
        -- min_height and max_height can be a single value or a list of mixed integer/float types.
        -- max_height = {80, 0.9} means "the lesser of 80 columns or 90% of total"
        max_height = 0.9,
        -- min_height = {5, 0.1} means "the greater of 5 columns or 10% of total"
        min_height = { 5, 0.1 },
        -- optionally define an integer/float for the exact height of the preview window
        height = nil,
        border = nil,
        win_options = {
          winblend = 0,
        },
      },
      -- Configuration for the floating progress window
      progress = {
        max_width = 0.9,
        min_width = { 40, 0.4 },
        width = nil,
        max_height = { 10, 0.9 },
        min_height = { 5, 0.1 },
        height = nil,
        border = nil,
        minimized_border = "none",
        win_options = {
          winblend = 0,
        },
      },
      -- Configuration for the floating SSH window
      ssh = {
        border = nil,
      },
      -- Configuration for the floating keymaps help window
      keymaps_help = {
        border = nil,
      },
    },
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
      "3rd/image.nvim",
    },
    cmd = "Neotree",

    wk_groups = { "<leader>T", desc = "Neo-Tree" },
    -- stylua: ignore
    keys = {
        {
            "<leader>Tr",
            function()
                require("neo-tree.command").execute({ toggle = true, source = "buffers", position = "left", })
            end,
            desc = "Buffers (root dir)",
            mode = "n",
        },
        {
            "<leader>Tg",
            function()
                require("neo-tree.command").execute({ toggle = true, source = "git_status", position = "left", })
            end,
            desc = "Buffers (root dir)",
            mode = "n",
        },
        {
            "<leader>t",
            function()
                require("neo-tree.command").execute({ toggle = true, position = "left" })
            end,
            desc = "Browse",
            mode = "n",
        },
    },
    deactivate = function()
      vim.cmd([[Neotree close]])
    end,
    opts = {
      sources = { "filesystem", "buffers", "git_status" },
      open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = { enabled = false },
        use_libuv_file_watche = true,
        filtered_items = {
          visible = true,
        },
      },
      commands = {
        system_open = function(state)
          local node = state.tree:get_node()
          local path = node:get_id()
          vim.fn.jobstart({ "xdg-open", path }, { detach = true })
        end,
        path_to_system_clipboard = function(state)
          local node = state.tree:get_node()
          local path = node:get_id()
          vim.fn.setreg("+", path, "c")
        end,
        open_in_system_browser = function(state)
          vim.fn.jobstart({ "xdg-open", state.path }, { detach = true })
        end,
      },
      window = {
        mappings = {
          ["l"] = "open",
          ["h"] = "close_node",
          ["<space>"] = "none",
          ["Y"] = "path_to_system_clipboard",
          ["O"] = "system_open",
          ["o"] = "open_in_system_browser",
          ["/"] = "noop",
          ["P"] = {
            "toggle_preview",
            config = {
              use_float = false,
              use_snacks_image = false,
              use_image_nvim = true,
            },
          },
        },
      },
    },
  },

  {
    "HakonHarnes/img-clip.nvim",
    event = "VeryLazy",
    opts = { default = { dir_path = "./", use_absolute_path = false } },
    keys = {
      { "<leader>p", "<CMD>PasteImage<CR>", desc = "Paste iamge from system clipboard" },
    },
  },
}
