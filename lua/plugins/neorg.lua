return {
	"nvim-neorg/neorg",
	dependencies = {
		"3rd/image.nvim",
	},
	lazy = false,
	version = "*",
	opts = {
		load = {
			["core.defaults"] = {},
			["core.concealer"] = {},
			["core.latex.renderer"] = {},
			["core.integrations.image"] = {
				conceal = true,
				render_on_enter = true,
			},
			["core.dirman"] = {
				config = {
					workspaces = {
						notes = "~/neorg-test",
					},
					default_workspace = "notes",
				},
			},
		},
	},
	setup = function(opts)
		require("neorg").setup(opts)
		vim.wo.foldlevel = 99
		vim.wo.conceallevel = 2
	end,
}
