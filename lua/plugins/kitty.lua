-- set explicitly, so lazyvim detects keybintings
vim.g.kitty_navigator_no_mappings = 1

local herdr_navigate = vim.fn.expand("~/.config/herdr/navigate.sh")
local herdr_resize = vim.fn.expand("~/.config/herdr/resize.sh")
local outer_terminal = vim.fn.expand("~/.config/herdr/outer.sh")
local in_ghostty = vim.env.TERM_PROGRAM == "ghostty"

-- move to the nvim split in `dir`; at the nvim edge hand off to herdr (if inside herdr) or kitty
local function navigate(wincmd, dir, kitty_cmd)
  return function()
    local win = vim.api.nvim_get_current_win()
    vim.cmd("wincmd " .. wincmd)
    if vim.api.nvim_get_current_win() ~= win then
      return
    end
    if vim.env.HERDR_ENV == "1" then
      vim.fn.jobstart({ herdr_navigate, dir, "--from-nvim" }, { detach = true })
    elseif in_ghostty then
      vim.fn.jobstart({ outer_terminal, "nav", dir }, { detach = true })
    elseif vim.env.KITTY_PID ~= nil then
      vim.cmd(kitty_cmd)
    end
  end
end

local function has_neighbor(wincmd)
  return vim.fn.winnr(wincmd) ~= vim.fn.winnr()
end

-- move the split divider in `dir`; returns 1 if nvim had a split on that axis, else 0
-- global, so herdr's resize.sh can call it over RPC
function _G.SeamlessResize(dir)
  local step = 2
  local horizontal = dir == "left" or dir == "right"
  local after, before = "l", "h"
  if not horizontal then
    after, before = "j", "k"
  end
  local delta
  if has_neighbor(after) then
    delta = (dir == "right" or dir == "down") and step or -step
  elseif has_neighbor(before) then
    delta = (dir == "right" or dir == "down") and -step or step
  else
    return 0
  end
  vim.cmd((horizontal and "vertical " or "") .. "resize " .. string.format("%+d", delta))
  return 1
end

local function resize(dir, kitty_dir, key)
  return function()
    if SeamlessResize(dir) == 1 then
      return
    end
    if vim.env.HERDR_ENV == "1" then
      vim.fn.jobstart({ herdr_resize, dir, "--from-nvim" }, { detach = true })
    elseif in_ghostty then
      vim.fn.jobstart({ outer_terminal, "resize", dir }, { detach = true })
    elseif vim.env.KITTY_PID ~= nil then
      vim.fn.jobstart({ "kitten", "@", "action", "kitten", "pass_resize.py", kitty_dir, key, "force" }, { detach = true })
    end
  end
end

return {
  {
    "hermitmaster/nvim-kitty-navigator",
    -- build = "cp ./*.py ~/.config/kitty/",
    cond = function()
      return vim.env.KITTY_PID ~= nil or vim.env.HERDR_ENV == "1" or in_ghostty
    end,
    keys = {
      { "<C-h>", navigate("h", "left", "KittyNavigateLeft"), silent = true, desc = "Navigate left" },
      { "<C-l>", navigate("l", "right", "KittyNavigateRight"), silent = true, desc = "Navigate right" },
      { "<C-j>", navigate("j", "down", "KittyNavigateDown"), silent = true, desc = "Navigate down" },
      { "<C-k>", navigate("k", "up", "KittyNavigateUp"), silent = true, desc = "Navigate up" },
      { "<C-S-h>", resize("left", "left", "ctrl+shift+h"), silent = true, desc = "Resize left" },
      { "<C-S-l>", resize("right", "right", "ctrl+shift+l"), silent = true, desc = "Resize right" },
      { "<C-S-j>", resize("down", "bottom", "ctrl+shift+j"), silent = true, desc = "Resize down" },
      { "<C-S-k>", resize("up", "top", "ctrl+shift+k"), silent = true, desc = "Resize up" },
    },
    opts = {},
  },
}
