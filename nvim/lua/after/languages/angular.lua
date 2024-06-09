local lsp_helpers = require("after.languages.lsp")
local on_attach = lsp_helpers.on_attach
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

--local project_library_path = "~/.local/share/nvim/mason/bin/ngserver"
--local cmd =
--    { "ngserver", "--stdio", "--tsProbeLocations", project_library_path, "--ngProbeLocations", project_library_path }

require("lspconfig").angularls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})
