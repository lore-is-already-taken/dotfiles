-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Line numbers: absolute only (LazyVim enables relativenumber by default)
vim.opt.relativenumber = false

-- Spell-checking
vim.opt.spell = true -- enable spell checker
vim.opt.spelllang = { "en" }
-- Keep custom dictionary words version-controlled in this repo
vim.opt.spellfile = vim.fn.expand("~/repos/dotfiles/nvim/spell/en.utf-8.add")

-- Clipboard: use the system clipboard for all operations
vim.opt.clipboard = "unnamedplus"

-- Fix copy and paste in WSL (Windows Subsystem for Linux)
if vim.fn.has("wsl") == 1 then
  vim.g.clipboard = {
    name = "win32yank", -- Use win32yank for clipboard operations
    copy = {
      ["+"] = "win32yank.exe -i --crlf", -- Command to copy to the system clipboard
      ["*"] = "win32yank.exe -i --crlf", -- Command to copy to the primary clipboard
    },
    paste = {
      ["+"] = "win32yank.exe -o --lf", -- Command to paste from the system clipboard
      ["*"] = "win32yank.exe -o --lf", -- Command to paste from the primary clipboard
    },
    cache_enabled = false, -- Disable clipboard caching
  }
end
