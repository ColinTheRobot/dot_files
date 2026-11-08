-- Languages enabled on this machine, one per line in ~/.config/dotfiles/langs
-- (written by install.sh --lang; not in the repo).
local M = {}

local enabled = {}
local path = vim.fn.expand("~/.config/dotfiles/langs")
if vim.fn.filereadable(path) == 1 then
  for _, line in ipairs(vim.fn.readfile(path)) do
    enabled[vim.trim(line)] = true
  end
end

function M.enabled(lang)
  return enabled[lang] == true
end

return M
