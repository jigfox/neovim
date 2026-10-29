-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.mapleader = ","
vim.g.maplocalleader = ","
vim.g.lazyvim_picker = "telescope"

vim.filetype.add({
  filename = {
    [".envrc"] = "bash",
    ["Kubeconfig"] = "yaml",
  },
  pattern = {
    ["~/.kube/config"] = "yaml",
  },
  extension = {
    mjml = "html",
  },
})

vim.treesitter.query.add_predicate("is-mise?", function(_, _, bufnr, _)
  local filepath = vim.api.nvim_buf_get_name(bufnr)
  local filename = vim.fn.fnamemodify(filepath, ":t")
  return filename == "mise.toml" or filename == ".mise.toml" or filename == "config.toml"
end, { force = true })
