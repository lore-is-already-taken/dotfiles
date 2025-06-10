local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

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

	{ import = "main.plugins" },
}, {})
