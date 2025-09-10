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
          codeLens = {
            enable = true,
          },
          completion = {
            callSnippet = "Replace",
          },
          doc = {
            privateName = { "^_" },
          },
          hint = {
            enable = true,
            setType = false,
            paramType = true,
            paramName = "Disable",
            semicolon = "Disable",
            arrayIndex = "Disable",
          },
          telemetry = { enable = false },
        },
      },
    },
    texlab = {
      settings = {
        texlab = {
          build = {
            executable = "latexmk",
            args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "-auxdir=build", "%f" },
            onSave = true,
            pdfDirectory = ".",
          },
          forwardSearch = {
            executable = "zathura",
            args = { "--synctex-forward", "%l:1:%f", "%p" },
          },
        },
      },
    },
    tinymist = {
      on_attach = function(client, bufnr)
        local fullfile = vim.api.nvim_buf_get_name(bufnr)
        local basename = vim.fs.basename(fullfile)
        if vim.fs.basename(fullfile) == "main.typ" or vim.uv.fs_stat(fullfile .. ".typstmain") then
          client:exec_cmd({
            title = "pin",
            command = "tinymist.pinMain",
            arguments = { fullfile },
          }, { bufnr = bufnr })
          vim.notify("Typst Main: '" .. fullfile .. "'")
        end

        local root = vim.fs.root(bufnr, ".git")
        if root == nil then
          root = "/"
        end

        local typstmain = vim.fs.find(function(name, path)
          return name == "main.typ" or name:match(".*.typstmain$")
        end, { limit = math.huge, type = "file", path = root })
        if #typstmain > 0 then
          local main = typstmain[1]
          if main:match(".*.typstmain$") then
            main = vim.fn.fnamemodify(main, ":r")
          end
          if not main:match(".*.typ$") then
            main = main .. ".typ"
          end

          if vim.uv.fs_stat(main) then
            client:exec_cmd({
              title = "pin",
              command = "tinymist.pinMain",
              arguments = { main },
            }, { bufnr = bufnr })
            vim.notify("!Typst Main: '" .. main .. "'")
          end
        end
      end,
    },
  },
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
      { "K", function() return vim.lsp.buf.hover() end, desc = "Hover", },
      { "gK", function() return vim.lsp.buf.signature_help() end, desc = "Signature Help", has = "signatureHelp", },
      { "<c-k>", function() return vim.lsp.buf.signature_help() end, mode = "i", desc = "Signature Help", has = "signatureHelp", },
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
