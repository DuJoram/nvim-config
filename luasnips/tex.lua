local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta

local function math()
  return vim.api.nvim_eval("vimtex#syntax#in_mathzone()") == 1
end

local function label_or_ref()
  local env = vim.api.nvim_eval("vimtex#cmd#get_current()")
  local env_name = env["name"]
  return env_name == "\\label" or env_name == "\\ref"
end

local function not_label_or_ref()
  return not label_or_ref()
end

local function not_math()
  return not math()
end

return {}, {
  s("mk", {
    t("\\("),
    i(1, ""),
    t("\\)"),
    i(0, ""),
  }, { condition = not_math }),
  s(
    { trig = "dm", name = "math", descr = "display math mode" },
    fmt(
      [[
    \[
    <>
    .\]
    <>]],
      { i(1), i(0) },
      { delimiters = "<>" }
    ),
    { condition = not_math }
  ),
  s({ trig = "mb", name = "mathbf", descr = "mathbf" }, fmta([[\mathbf{<>}<>]], { i(1), i(0) }), { condition = math }),
  s({ trig = "(%w+)mb", name = "mathbf 2", descr = "mathbf 2", regTrig = true }, {
    f(function(_, snip)
      return { "\\mathbf{" .. snip.captures[1] .. "}" }
    end, {}),
  }, { condition = math }),
  s(
    { trig = "td", name = "superscript", descr = "superscript", wordTrig = false },
    fmt([[^{<>}<>]], { i(1), i(0) }, { delimiters = "<>" }),
    { condition = math }
  ),
  s(
    { trig = "__", name = "subscript", descr = "subscript", wordTrig = false },
    fmt([[_{<>}<>]], { i(1), i(0) }, { delimiters = "<>" }),
    {
      condition = math,
    }
  ),
  s({
    trig = "([}A-Za-z])(%d)",
    name = "auto subscript",
    descr = "auto subscript",
    wordTrig = false,
    regTrig = true,
  }, {
    f(function(_, snip)
      return { snip.captures[1] .. "_" .. snip.captures[2] }
    end, {}),
  }, {
    condition = math,
  }),
  s({ trig = "_(%d%d)", name = "auto subscript 2", descr = "auto subscript 2", wordTrig = false, regTrig = true }, {
    f(function(_, snip)
      return { "_{" .. snip.captures[1] .. "}" }
    end, {}),
  }, {
    condition = math,
  }),
  s({
    trig = "([}A-Za-z])([ijk][ijk])",
    name = "auto subscript ijk",
    descr = "auto subscript ijk",
    wordTrig = false,
    regTrig = true,
  }, {
    f(function(_, snip)
      return { snip.captures[1] .. "_{" .. snip.captures[2] .. "}" }
    end, {}),
  }, {
    condition = math,
  }),

  s({ trig = "||", name = "mid", descr = "mid", wordTrig = false }, { t("\\mid ") }, {
    condition = math,
  }),
  s({ trig = "inn", name = "in", descr = "in", wordTrig = false }, { t("\\in ") }, {
    condition = math,
  }),
  s({ trig = "cc", name = "subset", descr = "subset", wordTrig = false }, { t("\\subset ") }, {
    condition = math,
  }),
  s(
    { trig = "mcal", name = "mathcal", descr = "mathcal" },
    fmta([[\mathcal{<>}<>]], { i(1), i(0) }),
    { condition = math }
  ),
  s({ trig = "(%w+)mcal", name = "mathcal 2", descr = "mathcal 2", regTrig = true }, {
    f(function(_, snip)
      return { "\\mathcal{" .. snip.captures[1] .. "}" }
    end, {}),
  }, { condition = math }),
  s({ trig = "!=", name = "not equals", descr = "not equals", wordTrig = false }, { t("\\neq") }, { condition = math }),
  s(
    { trig = "//", name = "fraction", descr = "fraction", wordTrig = false },
    fmta(
      [[
            \frac{<>}{<>}<>
            ]],
      { i(1), i(2), i(0) }
    ),
    { condition = math }
  ),
  s({ trig = "inv", name = "inverse", descr = "inverse", wordTrig = false }, { t("^{-1}") }, { condition = math }),
  s({ trig = "_{ii}nv", name = "inverse", descr = "inverse", wordTrig = false }, { t("i^{-1}") }, { condition = math }),
  s(
    { trig = "transp", name = "transpose", descr = "transpose", wordTrig = false },
    { t("^\\top") },
    { condition = math }
  ),
  s(
    { trig = "mr", name = "mathrm", descr = "mathrm", wordTrig = false },
    fmta([[\mathrm{<>}<>]], { i(1), i(0) }),
    { condition = math }
  ),
  s({ trig = "([%dA-Za-z])iset", name = "Index set", descr = "index set", wordTrig = false, regTrig = true }, {
    f(function(_, snip)
      return { "[" .. snip.captures[1] .. "]" }
    end, {}),
  }, { condition = math }),
  s(
    { trig = "set", name = "set", descr = "set", wordTrig = true },
    fmta([[\{<>\}<>]], { i(1), i(0) }),
    { condition = math }
  ),
  s({ trig = "~~", name = "sim", descr = "sim", wordTrig = false }, { t("\\sim ") }, { condition = math }),
  s({ trig = "~=", name = "approx", descr = "approx", wordTrig = false }, { t("\\approx ") }, { condition = math }),
  s({ trig = "...", name = "ldots", descr = "ldots" }, { t("\\ldots ") }, { condition = math }),
  s({ trig = "\\\\\\", name = "\\", descr = "\\", wordTrig = false }, { t("\\setminus ") }, { condition = math }),
  s({ trig = "==>", name = "==>", descr = "==>", wordTrig = false }, { t("\\Longrightarrow ") }, { condition = math }),
  s({ trig = "=>", name = "=>", descr = "=>", wordTrig = false }, { t("\\Rightarrow ") }, { condition = math }),
  s({ trig = "-->", name = "-->", descr = "-->", wordTrig = false }, { t("\\longrightarrow ") }, { condition = math }),
  s({ trig = "->", name = "->", descr = "->", wordTrig = false }, { t("\\rightarrow ") }, { condition = math }),
  s({ trig = "<-", name = "<-", descr = "<-", wordTrig = false }, { t("\\gets") }, { condition = math }),
  s(
    { trig = "\\gets-", name = "<--", descr = "<--", wordTrig = false },
    { t("\\longleftarrow ") },
    { condition = math }
  ),
  s(
    { trig = "\\leftarrow-", name = "<--2", descr = "<--2", wordTrig = false },
    { t("\\longleftarrow ") },
    { condition = math }
  ),
  s({ trig = "<=", name = "<=", descr = "<=", wordTrig = false }, { t("\\Leftarrow") }, { condition = math }),
  s(
    { trig = "\\Leftarrow=", name = "<==", descr = "<==", wordTrig = false },
    { t("\\Longleftarrow ") },
    { condition = math }
  ),
  s(
    { trig = "([A-Z])%1", name = "mathbb letter", descr = "mathbb letter", wordTrig = false, regTrig = true },
    { f(function(_, snip)
      return { "\\mathbb{" .. snip.captures[1] .. "}" }
    end, {}) },
    { condition = math }
  ),
  s(
    { trig = "msc", name = "mathsc", descr = "mathsc", wordTrig = false },
    fmta([[\mathscr{<>}<>]], { i(1), i(0) }),
    { condition = math }
  ),
  s(
    { trig = "mcal", name = "mathcal", descr = "mathcal", wordTrig = false },
    fmta([[\mathcal{<>}<>]], { i(1), i(0) }),
    { condition = math }
  ),
  s(
    { trig = "mcal", name = "mathcal", descr = "mathcal", wordTrig = false },
    fmta([[\mathcal{<>}<>]], { i(1), i(0) }),
    { condition = math }
  ),
  s(
    { trig = "lr(", name = "\\left(\\right)", descr = "\\left(\\right)", wordTrig = false },
    fmta([[\left(<>\right)<>]], { i(1), i(0) }),
    { condition = math }
  ),
  s(
    { trig = "lr[", name = "\\left[\\right]", descr = "\\left[\\right]", wordTrig = false },
    fmta([[\left[<>\right]<>]], { i(1), i(0) }),
    { condition = math }
  ),
  s(
    { trig = "lr{", name = "\\left{\\right}", descr = "\\left{\\right}", wordTrig = false },
    fmta([[\left\{<>\right\}<>]], { i(1), i(0) }),
    { condition = math }
  ),
  s(
    { trig = "lr<", name = "\\left<\\right>", descr = "\\left<\\right>", wordTrig = false },
    fmta([[\left\langle<>\right\rangle<>]], { i(1), i(0) }),
    { condition = math }
  ),
  s({
    trig = "ceil",
    name = "\\left\\lceil\\right\\rceil",
    descr = "\\left\\lceil\\right\\rfloor",
    wordTrig = false,
  }, fmta([[\left\lceil<>\right\rceil<>]], { i(1), i(0) }), { condition = math }),
  s({
    trig = "floor",
    name = "\\left\\lfloor\\right\\rfloor",
    descr = "\\left\\lfloor\\right\\rfloor",
    wordTrig = false,
  }, fmta([[\left\lceil<>\right\rceil<>]], { i(1), i(0) }), { condition = math }),
  s({
    trig = "ooo",
    name = "infinity",
    descr = "infinity",
    wordTrig = false,
  }, { t("\\infty") }, { condition = math }),
}
