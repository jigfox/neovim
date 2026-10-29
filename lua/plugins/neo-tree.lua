return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          hide_by_name = {
            "node_modules",
            "bin",
            "obj",
            ".git",
            ".vscode",
          },
          hide_dotfiles = false,
        },
      },
    },
  },
}
