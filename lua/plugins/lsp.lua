return {
	{
		"williamboman/mason.nvim",
		cmd = "Maosn",
		keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
		opts = {
			ensure_installed = {
				"shfmt",
				"isort",
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
		},
		opts = {
			ensure_installed = {
				"bashls",
				"clangd",
				"ltex",
				"lua_ls",
			},
			handlers = {
				function(server_name)
					require("lspconfig")[server_name].setup({})
				end,
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
		},
		config = function(_, opts)
			-- Extend configurations servers if set in config.lsp_configs.
			local lspconfig = require("lspconfig")
			for server, settings in pairs(require("config.lsp_configs").servers) do
				lspconfig[server].setup(settings)
			end
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
					".luarc.json"
				),
				sources = {
					null_ls.builtins.formatting.black,
					null_ls.builtins.formatting.fish_indent,
					null_ls.builtins.formatting.isort,
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.shfmt.with({ extra_args = { "-i", 2 } }),
					null_ls.builtins.diagnostics.fish,
				},
				on_attach = function(client, bufnr)
					if client.supports_method("textDocument/formatting") then
						vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = augroup,
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.format({ async = false })
							end,
						})
					end
				end,
			}
		end,
		config = function(_, opts)
			require("null-ls").setup(opts)

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = require("config.lsp_configs").on_attach,
			})
		end,
	},
}
