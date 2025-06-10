return {
	"3rd/image.nvim",
	opts = {
		backend = "kitty",
		integrations = {
			markdown = { enabled = true, filetypes = { "markdown", "vimwiki" } },
			neorg = { enabled = true, filetypes = { "norg" } },
		},
		max_width = 100,
		max_height = 12,
		max_height_window_percentage = math.huge,
		max_width_window_percentage = math.huge,
		window_overlap_clear_enabled = true,
		window_overlag_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
	},
}
