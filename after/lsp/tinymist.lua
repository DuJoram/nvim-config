return {
  on_attach = function(client, bufnr)
    local main = require("config.util").typst_find_main(bufnr)
    client:exec_cmd({
      title = "pin",
      command = "tinymist.pinMain",
      arguments = { main },
    }, { bufnr = bufnr })
    vim.notify("Typst Main: '" .. main .. "'")
  end,
}
