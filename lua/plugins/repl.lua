return {
	"Vigemus/iron.nvim",
	cmd = {
		"IronRepl",
		"IronReplHere",
		"IronRestart",
		"IronSend",
		"IronFocus",
		"IronHide",
		"IronWatch",
		"IronAttach",
	},
	keys = {
		"<leader>rr",
		"<leader>rR",
		"<leader>sc",
		"<leader>sc",
		"<leader>sf",
		"<leader>sl",
		"<leader>sp",
		"<leader>su",
		"<leader>sm",
		"<leader>sb",
		"<leader>sn",
		"<leader>mc",
		"<leader>mc",
		"<leader>md",
		"<leader>s",
		"<leader>s",
		"<leader>sq",
		"<leader>cl",
		{ "<leader>rs", "IronRepl" },
		{ "<leader>rr", "IronRestart" },
		{ "<leader>rf", "IronFocus" },
		{ "<leader>rh", "IronHide" },
	},
	main = "iron.core",
	config = function()
		local iron = require("iron.core")
		local view = require("iron.view")
		iron.setup({
			config = {
				scratch_repl = true,
				repl_definition = {
					sh = {
						command = { "fish" },
					},
				},
				repl_filetype = function(bufnr, ft)
					return ft
				end,

				repl_open_cmd = "botright 40 split",
			},

			keymaps = {
				toggle_repl = "<leader>rr",
				restart_repl = "<leader>rR",
				send_motion = "<leader>sc",
				visual_send = "<leader>sc",
				send_file = "<leader>sf",
				send_line = "<leader>sl",
				send_paragraph = "<leader>sp",
				send_until_cursor = "<leader>su",
				send_mark = "<leader>sm",
				send_code_block = "<leader>sb",
				send_code_block_and_move = "<leader>sn",
				mark_motion = "<leader>mc",
				mark_visual = "<leader>mc",
				remove_mark = "<leader>md",
				cr = "<leader>s",
				interrupt = "<leader>s",
				exit = "<leader>sq",
				clear = "<leader>cl",
			},
			highlight = { italic = true },
			ignore_blank_lines = true,
		})
	end,
}
