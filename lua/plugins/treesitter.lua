return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		build = ":TSUpdate",
		version = false,
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = { enable = true },
			sync_install = true,
			auto_intsall = true,
			matchup = {
				enable = true,
			},
			indremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
			ensure_installed = {
				"bash",
				"c",
				"c_sharp",
				"css",
				"cmake",
				"cpp",
				"dot",
				"fish",
				"gdscript",
				"godot_resource",
				"html",
				"javascript",
				"json",
				"lua",
				"luadoc",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"regex",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"yaml",
			},
			textobjects = {
				move = {
					enable = true,
					set_jumps = false,
					goto_next_start = {
						["]b"] = { query = "@code_cell.inner", desc = "Next code cell" },
					},
					goto_previous_start = {
						["[b"] = { query = "@code_cell.inner", desc = "Previous code cell" },
					},
				},
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["ib"] = { query = "@code_cell.inner", desc = "In block" },
						["ab"] = { query = "@code_cell.outer", desc = "Around block" },
					},
				},
				swap = {
					enable = true,
					swap_next = {
						["<leader>sbl"] = "@code_cell.outer",
					},
					swap_previous = {
						["<leader>sbh"] = "@code_cell.outer",
					},
				},
			},
		},
		keys = {
			{ "<c-space>", desc = "Increment selection" },
			{ "<bs>", desc = "Decrement selection", mode = "x" },
		},
		config = function(_, opts)
			local configs = require("nvim-treesitter.configs")
			configs.setup(opts)
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		init = function()
			local plugin = require("lazy.core.config").spec.plugins["nvim-treesitter"]
			local opts = require("lazy.core.plugin").values(plugin, "opts", false)
			local enabled = false
			if opts.textobjects then
				for _, mod in ipairs({ "move", "select", "swap", "lsp_interop" }) do
					if opts.textobjects[mod] and opts.textobjects[mod].enabled then
						enabled = true
						break
					end
				end
			end
			if not enabled then
				require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
			end
		end,
	},
}
