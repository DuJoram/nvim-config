local M = {}

function M.typst_find_main(bufnr)
  local root = vim.fs.root(bufnr, ".git")
  if root == nil then
    root = "/"
  end

  local typstmain = vim.fs.find(function(name, _)
    return name == "main.typ" or name:match(".*.typstmain$")
  end, { type = "file", path = root })
  if #typstmain > 0 then
    local main = typstmain[1]
    if main:match(".*.typstmain$") then
      main = vim.fn.fnamemodify(main, ":r")
    end
    if not main:match(".*.typ$") then
      main = main .. ".typ"
    end

    if vim.uv.fs_stat(main) then
      return main
    end
  end
  return vim.api.nvim_buf_get_name(bufnr)
end

return M
