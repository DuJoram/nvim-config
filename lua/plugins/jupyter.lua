return {
	{
		"GCBallesteros/jupytext.nvim",
		-- version = "0.2",
		opts = {
			style = "markdown",
			output_extension = "md",
			force_ft = "markdown",
		},
	},
	{
		"benlubas/molten-nvim",
		dependencies = { "3rd/image.nvim" },
		build = ":UpdateRemotePlugins",
		init = function()
			vim.g.molten_image_provider = "image.nvim"
			vim.g.molten_output_win_max_height = 20
			vim.g.molten_auto_ope_output = false
			vim.g.molten_wrap_output = true
			vim.g.molten_virt_text_output = true
			vim.g.molten_virt_lines_off_by_1 = true
		end,
		wk_groups = {
			{ "<localleader>m", desc = "Molten" },
			{ "<localleader>mo", desc = "Output" },
			{ "<localleader>e", desc = "Molten Evaluate" },
		},
		keys = {
			{
				"<localleader>mi",
				function()
					local venv = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX")
					if venv ~= nil then
						venv = string.match(venv, "/.+/(.+)")
						vim.cmd(("MoltenInit %s"):format(venv))
					else
						vim.cmd("MoltenInit python3")
					end
				end,
				desc = "Initialize Molten for python3",
			},
			-- { "<localleader>ee", ":MoltenEvaluateOperator<CR>", desc = "Run Operator Selection" },
			-- { "<localleader>el", ":MoltenEvaluateLine<CR>", desc = "Evaluate Line" },
			-- { "<localleader>er", ":MoltenReevaluateCell<CR>", desc = "Reevaluate Cell" },
			-- { "<localleader>er", ":<C-u>MoltenEvaluateVisual<CR>gv", desc = "Evaluate Visual", mode = "v" },
			-- { "<localleader>md", ":MoltenDelete<CR>", desc = "Delete Cell", mode = "v" },
			-- { "<localleader>moh", ":MoltenHideOutput<CR>", desc = "Hide Output" },
			-- { "<localleader>mos", ":noautocmd MoltenEnterOutput<CR>", desc = "Show/Enter Output" },
		},
	},
}
