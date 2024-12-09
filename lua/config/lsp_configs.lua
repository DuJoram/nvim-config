local M = {
	servers = {
		racket_langserver = {
			cmd = { "racket", "--lib", "racket-langserver" },
		},
		lua_ls = {
			settings = {
				Lua = {
					workspace = {
						checkThirdParty = false,
					},
					completion = {
						callSnippet = "Replace",
					},
				},
			},
		},
	},
	on_attach = function(callback_args)
        -- stylua: ignore
        local keymaps = {
            { "gd",         vim.lsp.buf.definition,                             desc = "Go To Definition",       has = "definition", },
            { "gr",         vim.lsp.buf.references,                             desc = "List References",        nowait = true, },
            { "gI",         vim.lsp.buf.implementation,                         desc = "Go To Implementation" },
            { "gy",         vim.lsp.buf.type_definition,                        desc = "Go To T[y]pe Definition" },
            { "gD",         vim.lsp.buf.declaration,                            desc = "Go To Declaration" },
            { "K",          function() return vim.lsp.buf.hover() end,          desc = "Hover", },
            { "gK",         function() return vim.lsp.buf.signature_help() end, desc = "Signature Help",         has = "signatureHelp", },
            { "<c-k>",      function() return vim.lsp.buf.signature_help() end, mode = "i",                      desc = "Signature Help", has = "signatureHelp", },
            { "<leader>cf", vim.lsp.buf.format,                                 mode = { "n", "v" },             desc = "Format",         has = "formatting", },
            { "<leader>ca", vim.lsp.buf.code_action,                            desc = "Code Action",            mode = { "n", "v" },     has = "codAction", },
        }

		local client = vim.lsp.get_client_by_id(callback_args.data.client_id)
		local wk = require("which-key")

		for _, keymap in ipairs(keymaps) do
			local has = (keymap.has == nil) or client.supports_method("textDocument/" .. keymap.has)
			keymap.has = nil

			if has then
				wk.add(keymap)
			end
		end
	end,
}

return M
