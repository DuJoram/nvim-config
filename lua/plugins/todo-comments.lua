return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	cmd = { "TodoTelescope" },
	event = { "BufReadPost", "BufNewFile" },
	config = true,

    -- stylua: ignore
    keys = {
        { "]t",         function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
        { "[t",         function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
        { "<leader>xt", "<cmd>TodoTelescope<cr>",                            desc = "Find Todo" },
        { "<leader>xT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>",    desc = "Find Todo/Fix/Fixme" },
    },
}
