return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		lazy = false,
		opts = {
			flavour = "mocha", -- latte, frappe, macchiato, mocha transparent_background = true, -- disables setting the background color.
			term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
		},
	},
	{
		"rebelot/kanagawa.nvim",
		priority = 1000,
		lazy = false,
		config = function()
			require("kanagawa").setup({
				compile = false, -- enable compiling the colorscheme
				undercurl = true, -- enable undercurls
				commentStyle = { italic = true },
				functionStyle = {},
				keywordStyle = { italic = true },
				statementStyle = { bold = true },
				typeStyle = {},
				transparent = true, -- do not set background color
				dimInactive = false, -- dim inactive window `:h hl-NormalNC`
				terminalColors = true, -- define vim.g.terminal_color_{0,17}
				colors = { -- add/modify theme and palette colors
					palette = {},
					theme = {
						wave = {},
						lotus = {},
						dragon = {},
						all = {
							ui = {
								bg_gutter = "none", -- set bg color for normal background
								bg_sidebar = "none", -- set bg color for sidebar like nvim-tree
								bg_float = "none", -- set bg color for floating windows
							},
						},
					},
				},
				overrides = function(colors) -- add/modify highlights
					return {
						LineNr = { bg = "none" },
						NormalFloat = { bg = "none" },
						FloatBorder = { bg = "none" },
						FloatTitle = { bg = "none" },
						TelescopeNormal = { bg = "none" },
						TelescopeBorder = { bg = "none" },
						LspInfoBorder = { bg = "none" },
					}
				end,
				theme = "wave", -- Load "wave" theme
				background = { -- map the value of 'background' option to a theme
					dark = "wave", -- try "dragon" !
					light = "lotus",
				},
			})
		end,
	},
	{
		"rose-pine/neovim",
		config = function()
			require("rose-pine").setup({
				disable_background = true, -- disables setting the background color
				disable_float_background = true, -- disables setting the background color for floating windows
				disable_italics = false, -- disables italics
				dim_inactive = {
					enabled = true, -- dim inactive windows
					shade = "dark", -- shade to use for dimming
					percentage = 0.15, -- percentage of dimming
				},
			})
		end,
	},
	{
		-- LazyVim configuration
		"LazyVim/LazyVim",
		opts = {
			-- Set the default color scheme
			colorscheme = "rose-pine",
		},
	}
}
