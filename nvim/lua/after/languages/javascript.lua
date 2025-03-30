local lsp_helpers = require("after.languages.lsp")
local on_attach = lsp_helpers.on_attach
--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require("lspconfig").ts_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	init_options = {
		plugins = {
			{
				name = "@vue/typescript-plugin",
				location = "/usr/local/lib/node_modules/@vue/typescript-plugin",
				languages = { "javascript", "typescript", "vue", "typescriptreact" },
			},
		},
	},
	filetypes = {
		"javascript",
		"vue",
		"typescript",
		"typescriptreact",
	},
})
require("lspconfig").emmet_language_server.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = {
		"javascript",
		"vue",
		"typescript",
		"typescriptreact",
	},
})
--require("lspconfig").volar.setup({ on_attach = on_attach })
-- You must make sure volar is setup
-- e.g. require'lspconfig'.volar.setup{}
-- See volar's section for more information
