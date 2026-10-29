local quickfile = require("snacks.quickfile")
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- 1. Auto-install the parser
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "gotmpl" })
      end
    end,
  },
}
