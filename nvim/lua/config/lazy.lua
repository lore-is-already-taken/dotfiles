-- This file contains the configuration for setting up the lazy.nvim plugin manager in Neovim.

-- Spell-checking
vim.opt.spell = true -- activa spell checker
vim.opt.spelllang = { "en" }

-- Define the path to the lazy.nvim plugin
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Check if the lazy.nvim plugin is not already installed
if not vim.loop.fs_stat(lazypath) then
  -- Bootstrap lazy.nvim by cloning the repository
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end

-- Prepend the lazy.nvim path to the runtime path
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

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

require("lazy").setup({
	{ "LazyVim/LazyVim", import = "lazyvim.plugins" },

	-- Editor plugins
	{ import = "lazyvim.plugins.extras.editor.harpoon2" },
	{ import = "lazyvim.plugins.extras.editor.mini-files" },
	{ import = "lazyvim.plugins.extras.editor.snacks_explorer" },
	{ import = "lazyvim.plugins.extras.editor.snacks_picker" },

	-- Coding plugins
	{ import = "lazyvim.plugins.extras.coding.mini-surround" },
	{ import = "lazyvim.plugins.extras.editor.mini-diff" },

	-- Utility plugins
	{ import = "lazyvim.plugins.extras.util.mini-hipatterns" },

	{ import = "plugins" },
	performance = {
		rtp = {
			-- Disable some runtime path plugins to improve performance
			disabled_plugins = {
				"gzip",
				-- "matchit",
				-- "matchparen",
				-- "netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
}, {})
