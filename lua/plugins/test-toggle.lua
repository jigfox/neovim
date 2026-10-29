return {
  {
    dir = "~/src/github.com/jigfox/test-toggle.nvim",
    name = "test-toggle",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    keys = function()
      local tt = require("test-toggle")
      return {
        { "<leader>to", tt.toggle_only, desc = "toggle it <=> it.only" },
        { "<leader>ts", tt.toggle_skip, desc = "toggle it <=> it.skip" },
      }
    end,
  },
}
