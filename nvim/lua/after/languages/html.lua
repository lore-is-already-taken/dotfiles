local lsp_helpers = require("after.languages.lsp")
local on_attach = lsp_helpers.on_attach

--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require("lspconfig").html.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	init_options = {
		configurationSection = { "html", "css", "javascript" },
		embeddedLanguages = {
			css = false,
			javascript = false,
		},
		provideFormatter = false,
	},
})
--vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
--    underline = true,
--    virtual_text = {
--        spacing = 5,
--        severity_limit = "Warning",
--    },
--    update_in_insert = true,
--})
