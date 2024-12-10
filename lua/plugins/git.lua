return {
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"nvim-telescope/telescope.nvim",
		},
		opts = {
			integrations = {
				telescope = true,
				diffview = true,
			},
		},
		config = function(_, opts)
			require("neogit").setup(opts)
			vim.api.nvim_create_user_command("G", "Neogit", {})
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		wk_groups = {
			{ "<leader>h", desc = "Git Hunks" },
		},
		opts = {
			on_attach = function(buffer)
				local gitsigns = require("gitsigns")
				local wk = require("which-key")

                -- stylua: ignore
                wk.add({
                    { '<leader>hs', gitsigns.stage_hunk,                                                       desc = "Stage Hunk",      buffer = buffer },
                    { '<leader>hr', gitsigns.reset_hunk,                                                       desc = "Reset Hunk",      buffer = buffer },
                    { '<leader>hs', function() gitsigns.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end, mode = 'v',               desc = "Stage Hunk ", buffer = buffer },
                    { '<leader>hr', function() gitsigns.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end, mode = 'v',               desc = "Reset Hunk ", buffer = buffer },
                    { '<leader>hS', gitsigns.stage_buffer,                                                     desc = "Stage Buffer",    buffer = buffer },
                    { '<leader>hu', gitsigns.undo_stage_hunk,                                                  desc = "Undo Stage Hunk", buffer = buffer },
                    { '<leader>hR', gitsigns.reset_buffer,                                                     desc = "Reset Buffer",    buffer = buffer },
                    { '<leader>hp', gitsigns.preview_hunk,                                                     desc = "Preview Hunk",    buffer = buffer },
                    { '<leader>hb', function() gitsigns.blame_line { full = true } end,                        desc = "Blame Line ",     buffer = buffer },
                    -- { '<leader>tb', gitsigns.toggle_current_line_blame,                       desc = "Toggle Current Line Blame" , buffer = buffer},
                    { '<leader>hd', gitsigns.diffthis,                                                         desc = "Diff This",       buffer = buffer },
                    { '<leader>hD', function() gitsigns.diffthis('~') end,                                     desc = "Diff This",       buffer = buffer },
                    -- { '<leader>td', gitsigns.toggle_deleted,                                  desc = "Toggle Deleted" , buffer = buffer},
                })
			end,
		},
	},
}
