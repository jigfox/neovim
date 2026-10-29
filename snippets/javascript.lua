local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local sn = ls.snippet_node
local fmta = require("luasnip.extras.fmt").fmta

local function addPrefix(args, _, user_args)
  return user_args .. args[1][1]:gsub("^%l", string.upper)
end

return {
  -- s({ trig = "arr" }, fmta([[() => {<>}]], { i(1) })),
  s(
    { trig = "uss2" },
    fmta([[const [<>, <>] = useState(<>);]], {
      i(2, "state"),
      d(3, function(args)
        return sn(nil, {
          i(1, "set" .. args[1][1]:gsub("^%l", string.upper)),
        })
      end, { 2 }),
      i(1),
    })
  ),
}
