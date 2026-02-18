local function keyboard_layout()
  local handle = io.popen("niri msg keyboard-layouts 2>/dev/null")
  if not handle then
    return ""
  end

  local result = handle:read("*a")
  handle:close()

  -- Find the line with asterisk (current layout)
  for line in result:gmatch("[^\r\n]+") do
    if line:match("^%s*%*") then
      -- Extract layout name after the number
      local layout = line:match("%d+%s+(.+)$")
      if layout and layout ~= "English (US)" then
        return "⚠ " .. layout .. " ⚠"
      end
      break
    end
  end

  return ""
end

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    options = {
      icons_enabled = true,
      theme = "auto",
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", "diff", "diagnostics" },
      lualine_c = { "filename" },
      lualine_x = {
        {
          keyboard_layout,
          color = { fg = "#ff0000", bg = "#000000", gui = "bold" },
          separator = { left = "", right = "" },
        },
        "encoding",
        "fileformat",
        { "filetype", icon = { align = "right" } },
      },
      lualine_z = { "location" },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { "filename" },
      lualine_x = { "location" },
      lualine_y = {},
      lualine_z = {},
    },
    extensions = { "neo-tree", "lazy" },
  },
}
