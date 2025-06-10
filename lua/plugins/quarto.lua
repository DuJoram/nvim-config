local function runner()
	return require("quarto.runner")
end

local function quarto()
	return require("quarto")
end

local function quarto_preview()
	return quarto().quartoPreview
end

local function runner_run_cell()
	return runner().run_cell
end

local function runner_run_above()
	return runner().run_above
end

local function runner_run_all()
	return runner().run_all
end

local function runner_run_line()
	return runner().run_line
end

local function runner_run_range()
	return runner().run_range
end

return {
	"quarto-dev/quarto-nvim",
	dependencies = {
		"jmbuhr/otter.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	opts = {
		debug = false,
		closePreviewOnExit = true,
		lspFeatures = {
			languages = { "python", "julia" },
			chunks = "all",
			diagnostics = {
				enabled = true,

				triggers = { "BufWritePost" },
			},
			completion = {
				enabled = true,
			},
		},
		codeRunner = {
			enabled = true,
			default_method = "molten",
			ft_runners = { python = "molten" },
		},
		keymap = {
			hover = "H",
			definition = "gd",
			rename = "<leader>rn",
			references = "gr",
			format = "<leader>gf",
		},
	},
	keys = {
		{ "<localleader>qp", ":QuartoPreview<CR>", desc = "Quarto Preview" },
		{ "<localleader>ec", ":QuartoSend<CR>", desc = "Evaluate cell" },
		{ "<localleader>ea", ":QuartoSendAbove<CR>", desc = "Evaluate cell above" },
		{ "<localleader>eA", ":QuartoSendAll<CR>", desc = "Evaluate all cells" },
		{ "<localleader>el", ":QuartoSendLine<CR>", desc = "Evaluate line" },
		{ "<localleader>er", ":QuartoSendRange<CR>", desc = "Evaluate visual" },
	},
}
