local M = {}

function M.typst_find_main(bufnr_or_file)
  -- vim.notify("" .. bufnr_or_file)

  -- Get the starting path (directory of current file)
  local start_path
  if type(bufnr_or_file) == "number" then
    start_path = vim.api.nvim_buf_get_name(bufnr_or_file)
  else
    start_path = bufnr_or_file
  end
  start_path = vim.fn.fnamemodify(start_path, ":p:h")

  -- Find git root or filesystem root as stopping point
  local stop_at = vim.fs.root(start_path, ".git") or "/"

  local typstmain = vim.fs.find(function(name, _)
    return (name == "main.typ") or (name:match(".*.typstmain$"))
  end, { type = "file", path = start_path, upward = true, stop = stop_at })

  if #typstmain > 0 then
    local main = typstmain[1]
    if main:match(".*.typstmain$") then
      main = vim.fn.fnamemodify(main, ":r")
    end
    if not main:match(".*.typ$") then
      main = main .. ".typ"
    end

    if vim.uv.fs_stat(main) then
      -- vim.notify("Typst Main: " .. main)
      return main
    end
  end

  local main = bufnr_or_file
  if type(bufnr_or_file) == "number" then
    main = vim.api.nvim_buf_get_name(bufnr_or_file)
  end
  -- vim.notify("Typst Main: " .. main)
  return main
end

--- Write clipboard contents to a file if it contains a recognized file type.
--- @param filepath string Destination path (including filename)
--- @param opts? { on_success?: fun(path: string), on_error?: fun(err: string) }
--- @return boolean success
function M.clipboard_to_file(filepath, opts)
  opts = opts or {}

  local mimes = vim.fn.system("wl-paste -l")
  if vim.v.shell_error ~= 0 then
    if opts.on_error then
      opts.on_error("Failed to query clipboard")
    end
    return false
  end

  -- Map MIME types to file extensions
  local mime_to_ext = {
    ["image/png"] = "png",
    ["image/jpeg"] = "jpg",
    ["image/gif"] = "gif",
    ["image/webp"] = "webp",
    ["image/svg+xml"] = "svg",
    ["image/bmp"] = "bmp",
    ["application/pdf"] = "pdf",
    ["text/plain"] = "txt",
    ["text/html"] = "html",
  }

  local detected_mime, detected_ext
  for mime, ext in pairs(mime_to_ext) do
    if mimes:match(mime) then
      detected_mime = mime
      detected_ext = ext
      break
    end
  end

  if not detected_mime then
    if opts.on_error then
      opts.on_error("No recognized file type in clipboard")
    end
    return false
  end

  -- Append extension if filepath doesn't have one
  if not filepath:match("%.[^/]+$") then
    filepath = filepath .. "." .. detected_ext
  end

  local cmd = string.format("wl-paste -t %q > %q", detected_mime, filepath)
  vim.fn.system(cmd)

  if vim.v.shell_error ~= 0 then
    if opts.on_error then
      opts.on_error("Failed to write clipboard to file")
    end
    return false
  end

  if opts.on_success then
    opts.on_success(filepath)
  end
  return true
end

return M
