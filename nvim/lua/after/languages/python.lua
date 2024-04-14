-- Python SETUP LSP
local lsp_helpers = require("after.languages.lsp")
local on_attach = lsp_helpers.on_attach

require("lspconfig").pyright.setup({
	on_attach = on_attach,
	settings = {
		filetypes = { "python" },
	},
})
