return {
	{
		"lervag/vimtex",
		ft = { "tex", "latex", "plaintex" },
		cmd = "VimtexInverseSearch",
		config = function(_, _)
			vim.g.tex_stylish = 1
			vim.g.tex_flavor = "latex"
			vim.g.vimtex_fold_enabeld = 0
			vim.g.vimtex_format_enabled = 1
			vim.g.vimtex_matchparen_enabled = 1
			vim.g.vimtex_view_method = "zathura"
			vim.g.vimtex_view_general_viewer = "zathura"
			vim.g.vimtex_view_zathura_check_libsynctex = 1
			vim.g.vimtex_view_automatic = 0
			vim.g.vimtex_view_forward_search_on_start = 0
			vim.g.vimtex_toc_config = {
				split_pos = "vert leftabove",
				mode = 2,
				fold_enable = 0,
				hotkeys_enabled = 1,
				hotkeys_leader = "",
				refresh_always = 0,
			}

			vim.g.vimtex_quickfix_open_on_warning = 0
			vim.g.vimtex_quickfix_autoclose_after_keystrokes = 3
			vim.g.vimtex_imaps_enabled = 1
			vim.g.vimtex_complete_img_use_tail = 1
			vim.g.vimtex_complete_bib = {
				simple = 1,
				menu_fmt = "@year, @author_short, @title",
			}

			vim.g.vimtex_echo_verbose_input = 0

			vim.g.vimtex_compiler_method = "latexmk"
			vim.g.vimtex_compiler_latexmk = {
				background = 1,
				aux_dir = "build/",
				callback = 1,
				continuous = 1,
				executable = "latexmk",
				hooks = {},
				options = {
					"-pdf",
					"-verbose",
					"-file-line-error",
					"-synctex=1",
					"-interaction=nonstopmode",
				},
			}

			vim.g.vimtex_compile_latexmk_engines = {
				["pdftex"] = "-pdf -pdflatex=pdftex",
			}
		end,
	},
	{
		"andymass/vim-matchup",
		setup = function()
			vim.g.matchup_matchparen_offscreen = { method = "popup" }
		end,
	},
}
