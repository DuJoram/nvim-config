local M = {
  formatter_servers = {
    racket_langserver = true,
  },
  on_attach = function(callback_args)
     -- stylua: ignore
    local keymaps = {
      { "gd", vim.lsp.buf.definition, desc = "Go To Definition", has = "definition" },
      { "gr", vim.lsp.buf.references, desc = "List References", nowait = true },
      { "gI", vim.lsp.buf.implementation, desc = "Go To Implementation" },
      { "gy", vim.lsp.buf.type_definition, desc = "Go To T[y]pe Definition" },
      { "gD", vim.lsp.buf.declaration, desc = "Go To Declaration" },
      { "K", vim.lsp.buf.hover, desc = "Hover", },
      { "gK", function() return vim.lsp.buf.signature_help() end, desc = "Signature Help", has = "signatureHelp", },
      { "<c-k>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help", has = "signatureHelp", },
      { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" }, has = "codeAction" },
      { "<leader>cc", vim.lsp.codelens.run, desc = "Run Codelens", mode = { "n", "v" }, has = "codeLens" },
      { "<leader>cC", vim.lsp.codelens.refresh, desc = "Refresh & Display Codelens", mode = { "n" }, has = "codeLens" },
      { "<leader>cd", vim.diagnostic.show, desc = "Show Diagnostics", mode = { "n", "v" }, has = "diagnostic" },
      { "<leader>cf", vim.lsp.buf.format, mode = { "n", "v" }, desc = "Format", has = "formatting" },
      { "<leader>cr", function()
          local inc_rename = require("inc_rename")
          return ":" .. inc_rename.config.cmd_name .. " " .. vim.fn.expand("<cword.")
        end,
        expr = true,
        desc = "Rename Symbol",
        mode = { "n", "v" },
        has = "rename",
      },
    }

    local client = vim.lsp.get_client_by_id(callback_args.data.client_id)
    if client == nil then
      return
    end

    local wk = require("which-key")

    for _, keymap in ipairs(keymaps) do
      local has = (keymap.has == nil) or client:supports_method("textDocument/" .. keymap.has)
      keymap.has = nil

      if has then
        wk.add(keymap)
      end
    end
  end,
}

return M
