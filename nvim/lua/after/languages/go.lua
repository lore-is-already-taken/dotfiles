local lsp_helpers = require("after.languages.lsp")
local on_attach = lsp_helpers.on_attach

require("lspconfig").gopls.setup({
	on_attach = on_attach,
})
