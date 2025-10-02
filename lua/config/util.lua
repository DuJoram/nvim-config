local M = {}

function M.typst_find_main(bufnr_or_file)
  vim.notify("" .. bufnr_or_file)

  local root = vim.fs.root(bufnr_or_file, ".git")
  if root == nil then
    root = "/"
  end

  local typstmain = vim.fs.find(function(name, _)
    return name == "main.typ" or name:match(".*.typstmain$")
  end, { type = "file", path = root, upward = true })
  if #typstmain > 0 then
    local main = typstmain[1]
    if main:match(".*.typstmain$") then
      main = vim.fn.fnamemodify(main, ":r")
    end
    if not main:match(".*.typ$") then
      main = main .. ".typ"
    end

    if vim.uv.fs_stat(main) then
      vim.notify("Typst Main: " .. main)
      return main
    end
  end

  local main = bufnr_or_file
  if type(bufnr_or_file) == "number" then
    main = vim.api.nvim_buf_get_name(bufnr_or_file)
  end
  vim.notify("Typst Main: " .. main)
  return main
end

return M
