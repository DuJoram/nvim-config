local wk = require("which-key")
local lazy_keys = require("lazy.core.handler").handlers.keys

wk.add({
	{
		mode = "n",

		{ "<leader>c", desc = "Commands" },

		-- Window navigation
		{ "<C-h>", "<C-w>h", desc = "Go to left window" },
		{ "<C-j>", "<C-w>j", desc = "Go to lower window" },
		{ "<C-k>", "<C-w>k", desc = "Go to upper window" },
		{ "<C-l>", "<C-w>l", desc = "Go to right window" },

		{ "<leader>w", group = "Window" },
		{ "<leader>ww", "<C-W>p", desc = "Other window" },
		{ "<leader>wd", "<C-W>c", desc = "Delete window" },
		{ "<leader>w-", "<C-W>s", desc = "Split window below" },
		{ "<leader>w|", "<C-W>v", desc = "Split window right" },
		{ "<leader>-", "<C-W>s", desc = "Split window below" },
		{ "<leader>|", "<C-W>v", desc = "Split window right" },

		-- Line edits
		{ "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" } },
		{ "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" } },

		-- Tabs
		{ "<leader><tab>", group = "Tabs" },
		{ "<leader><tab>l", "<cmd>tablast<cr>", desc = "Last Tab" },
		{ "<leader><tab>f", "<cmd>tabfirst<cr>", desc = "First Tab" },
		{ "<leader><tab><tab>", "<cmd>tabnew<cr>", desc = "New Tab" },
		{ "<leader><tab>]", "<cmd>tabnext<cr>", desc = "Next Tab" },
		{ "<leader><tab>d", "<cmd>tabclose<cr>", desc = "Close Tab" },
		{ "<leader><tab>[", "<cmd>tabprevious<cr>", desc = "Previous Tab" },
	},
	{
		mode = "i",

		-- Line edits
		{ "<A-j>", "<esc><cmd>m .+1<cr>==gi", desc = "Move down" },
		{ "<A-k>", "<esc><cmd>m .-2<cr>==gi", desc = "Move up" },
	},
	{
		mode = "v",

		-- Line edits
		{ "<A-j>", ":m '>+1<cr>gv=gv", desc = "Move down" },
		{ "<A-k>", ":m '<-2<cr>gv=gv", desc = "Move up" },

		-- Better indenting
		{ "<", "<gv", desc = "Decrease indentation of visual block" },
		{ ">", ">gv", desc = "Increase indentation of visual block" },
	},
})
