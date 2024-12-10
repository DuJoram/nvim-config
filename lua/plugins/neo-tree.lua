return {
	"nvim-neo-tree/neo-tree.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
		"3rd/image.nvim",
	},
	cmd = "Neotree",

    -- stylua: ignore
    keys = {
        {
            "<leader>Tr",
            function()
                require("neo-tree.command").execute({ toggle = true, source = "buffers", position = "left", })
            end,
            desc = "Buffers (root dir)",
            mode = "n",
        },
        {
            "<leader>Tg",
            function()
                require("neo-tree.command").execute({ toggle = true, source = "git_status", position = "left", })
            end,
            desc = "Buffers (root dir)",
            mode = "n",
        },
        {
            "<leader>t",
            function()
                require("neo-tree.command").execute({ toggle = true, position = "left" })
            end,
            desc = "Browse",
            mode = "n",
        },
    },
	deactivate = function()
		vim.cmd([[Neotree close]])
	end,
	opts = {
		sources = { "filesystem", "buffers", "git_status" },
		open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
		filesystem = {
			bind_to_cwd = false,
			follow_current_file = { enabled = false },
			use_libuv_file_watche = true,
		},
		commands = {
			system_open = function(state)
				local node = state.tree:get_node()
				local path = node:get_id()
				vim.fn.jobstart({ "xdg-open", path }, { detach = true })
			end,
			path_to_system_clipboard = function(state)
				local node = state.tree:get_node()
				local path = node:get_id()
				vim.fn.setreg("+", path, "c")
			end,
			open_in_system_browser = function(state)
				vim.fn.jobstart({ "xdg-open", state.path }, { detach = true })
			end,
		},
		window = {
			mappings = {
				["l"] = "open",
				["h"] = "close_node",
				["<space>"] = "none",
				["Y"] = "path_to_system_clipboard",
				["O"] = "system_open",
				["o"] = "open_in_system_browser",
			},
		},
	},
}
