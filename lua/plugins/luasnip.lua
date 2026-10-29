return {
  {
    "L3MON4D3/LuaSnip",
    config = function()
      require("luasnip").setup(opts)
      require("luasnip.loaders.from_lua").load({
        paths = { "~/.config/nvim/snippets" },
      })
    end,
  },
}
