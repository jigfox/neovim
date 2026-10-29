local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

return {
  -- stylua: ignore
  s({trig="if"}, fmta(
    [[
    @if (<>) {
      <>
    }
    ]],
    { i(1), i(2) }
  )),
  -- stylua: ignore
  s({trig="ife"}, fmta(
    [[
    @if (<>) {
      <>
    } @else {
      <>
    }
    ]],
    { i(1), i(2), i(3) }
  )),
  -- stylua: ignore
  s({trig = "else" }, {
    t({"} @else {", ""}),
    t("  "), i(1),
    t({"", "}"}),
  }),
  -- stylua: ignore
  s({trig = "else" }, {
    t({"@else {", ""}),
    t("  "), i(1),
    t({"", "}"}),
  }),
  -- stylua: ignore
  s({trig = "for"}, {
    t("@for ("), i(1), t({") {", ""}),
    t("  "), i(2),
    t({"", "}"}),
  }),
  -- stylua: ignore
  s({trig = "fore" }, {
    t("@for ("), i(1), t({") {", ""}),
    t("  "), i(2),
    t({"", "} @empty {", ""}),
    t("  "), i(3),
    t({"", "}"}),
  }),
}
