local lsp_helpers = require("after.languages.lsp")
local on_attach = lsp_helpers.on_attach

require("lspconfig").tsserver.setup({
	on_attach = on_attach,
	init_options = {
		plugins = {
			{
				name = "@vue/typescript-plugin",
				location = "/usr/local/lib/node_modules/@vue/typescript-plugin",
				languages = { "javascript", "typescript", "vue" },
			},
		},
	},
	filetypes = {
		"javascript",
		"typescript",
		"vue",
	},
})
require("lspconfig").volar.setup({})

-- You must make sure volar is setup
-- e.g. require'lspconfig'.volar.setup{}
-- See volar's section for more information
