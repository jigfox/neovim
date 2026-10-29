-- ============================================================================
-- CHEZMOI CONFIG (Must run absolutely first)
-- ============================================================================

-- 1. Register Filetype Detection
vim.filetype.add({
  extension = { gotmpl = "gotmpl" },
  pattern = { [".*%.(.-)%.tmpl"] = "gotmpl" },
})

-- 2. Register Custom Tree-sitter Directive
-- We wrap this in a pcall and explicit require to ensure it works even if
-- Neovim is in a super-early startup state (fixing the Snacks race condition).
local ok, query = pcall(require, "vim.treesitter.query")
if ok and query then
  query.add_directive("inject-chezmoi!", function(_, _, bufnr, _, metadata)
    -- [FIX] Defensive check: Ensure we have a valid buffer number.
    -- blink.cmp or other floating windows might pass nil here.
    if not bufnr or type(bufnr) ~= "number" then
      return
    end
    local filename = vim.api.nvim_buf_get_name(bufnr)
    -- Capture extension before .tmpl
    local ext = filename:match(".*%.(.-)%.tmpl$") or "html"

    -- Map extension to treesitter language
    local mappings = {
      sh = "bash",
      zsh = "bash",
      yml = "yaml",
      py = "python",
      rs = "rust",
    }
    metadata["injection.language"] = mappings[ext] or ext
  end, {})
end
-- ============================================================================

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
