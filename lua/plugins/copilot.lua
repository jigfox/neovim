-- Work directories (one per line) are written by chezmoi, so they stay out of this repo
local function work_dirs()
  local dirs = {}
  local file = io.open(vim.fn.expand("~/.config/nvim-copilot-dirs"))
  if not file then
    return dirs
  end
  for line in file:lines() do
    if line ~= "" then
      table.insert(dirs, vim.fn.expand(line))
    end
  end
  file:close()
  return dirs
end

local function is_work_dir()
  local cwd = vim.fn.getcwd()
  for _, dir in ipairs(work_dirs()) do
    if vim.startswith(cwd, dir) then
      return true
    end
  end
  return false
end

return {
  {
    "zbirenbaum/copilot.lua",
    cond = is_work_dir,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    cond = is_work_dir,
  },
}
