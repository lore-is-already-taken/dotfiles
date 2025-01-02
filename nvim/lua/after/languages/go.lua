local lsp_helpers = require("after.languages.lsp")
local on_attach = lsp_helpers.on_attach
local capabilities = vim.lsp.protocol.make_client_capabilities()

require("lspconfig").gopls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})
