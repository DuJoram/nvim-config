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
		},
		keys = {
			{ "<c-space>", desc = "Increment selection" },
			{ "<bs>", desc = "Decrement selection", mode = "x" },
		},
		config = function(_, opts)
			local configs = require("nvim-treesitter.configs")
			configs.setup(opts)
			require("nvim-treesitter").setup(opts)
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
