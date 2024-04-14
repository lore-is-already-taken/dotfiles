local lsp_helpers = require("after.languages.lsp")
local on_attach = lsp_helpers.on_attach

--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require("lspconfig").cssls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})
