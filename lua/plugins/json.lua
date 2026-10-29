return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      jsonls = {
        filetypes = { "json", "jsonc", "json5" }, -- include all
        settings = {
          json = {
            validate = { enable = true },
          },
        },
      },
    },
  },
}
