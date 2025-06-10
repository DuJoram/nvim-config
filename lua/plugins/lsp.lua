return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    opts = {
      ensure_installed = {
        "shfmt",
        -- "isort",
        "stylua",
        "luacheck",
        --     "shfmt",
        --     "isort",
        --     "bash-language-server",
        --     "clangd",
        --     "ltex-ls",
        --     "stylua",
        --     "lua-language-server",
        --     "luacheck",
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      local registry = require("mason-registry")
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = registry.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end

      if registry.refresh then
        registry.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      ensure_installed = {
        "bashls",
        "clangd",
        "ltex",
        "lua_ls",
      },
      -- handlers = {
      -- 	function(server_name)
      -- 		require("lspconfig")[server_name].setup({})
      -- 	end,
      -- },
    },
  },

  {
    "neovim/nvim-lspconfig",
    config = function(_, opts)
      -- Extend configurations servers if set in config.lsp.
      local lspconfig = require("lspconfig")
      for server, settings in pairs(require("config.lsp").servers) do
        lspconfig[server].setup(settings)
      end

      vim.api.nvim_create_autocmd("User", {
        pattern = "LspSupportsMethod",
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          local buffer = args.data.buffer
          if client then
            if
              "textDocument/inlayHint" == args.data.method
              and vim.api.nvim_buf_is_valid(buffer)
              and vim.bo[buffer].buftype == ""
              and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[buffer].filetype)
            then
              vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
            end
            if "textDocument/codeLens" == args.data.method then
              vim.lsp.codelens.refresh()
              vim.api.nvim_create_autocmd(
                { "BufEnter", "CursorHold", "InsertLeave" },
                { buffer = buffer, callback = vim.lsp.codelens.refresh }
              )
            end
          end
        end,
      })
      vim.diagnostic.config({
        underline = true,
        virtual_text = true,
        virtual_lines = false,
      })
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = function()
      local null_ls = require("null-ls")
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      return {
        root_dir = require("null-ls.utils").root_pattern(
          ".null-ls-root",
          "Makefile",
          "compile_commands.json",
          ".git",
          "stylua.toml",
          ".luarc.json"
        ),
        sources = {
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.fish_indent,
          null_ls.builtins.formatting.isort,
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.clang_format,
          null_ls.builtins.formatting.shfmt.with({ extra_args = { "-i", 2 } }),
          null_ls.builtins.diagnostics.fish,
        },
        on_attach = function(client, bufnr)
          local formatter_servers = require("config.lsp").formatter_servers
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({
                  bufnr = bufnr,
                  async = false,
                  filter = function(client_)
                    local res = (
                      formatter_servers[client_.name] ~= nil
                      -- Strange form. But a non-nil, non-boolean variable evaluates to true.
                      and (formatter_servers[client_.name] == true)
                    ) or client_.name == "null-ls"
                    return res
                  end,
                })
              end,
            })
          end
        end,
      }
    end,
    config = function(_, opts)
      require("null-ls").setup(opts)

      local lspconfig = require("config.lsp")

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = lspconfig.on_attach,
      })
    end,
  },
  {
    "smjonas/inc-rename.nvim",
    config = function()
      require("inc_rename").setup()
    end,
  },
}
