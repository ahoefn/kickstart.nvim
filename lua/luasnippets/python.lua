local ls = require 'luasnip'
local fmt = require('luasnip.extras.fmt').fmt

local ins = ls.insert_node

local snippets = {
  -- General snippets
  ls.snippet(
    { trig = 'def', desc = 'define a function' },
    fmt(
      [[
        def {}({}) -> {}:
            {}
      ]],
      { ins(1), ins(2), ins(3), ins(0) }
    )
  ),

  -- Test snippets
  ls.snippet(
    { trig = 'test', desc = 'pytest test function' },
    fmt(
      [[
         def test_{}() -> None:
             {}
                ]],
      { ins(1), ins(0) }
    )
  ),
}
return snippets
