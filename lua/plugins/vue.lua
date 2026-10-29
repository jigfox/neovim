local tsdk = function()
  return vim.fn.getcwd() .. "/node_modules/typescript/lib"
end

return {
  {

    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers.volar = {
        filetypes = { "vue" },
        init_options = {
          vue = { hybridMode = false },
          typescript = { tsdk = tsdk() },
        },
      }
    end,
  },
}
