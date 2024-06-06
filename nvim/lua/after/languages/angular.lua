local lsp_helpers = require("after.languages.lsp")
local on_attach = lsp_helpers.on_attach
--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local cmd =
	{ "ngserver", "--stdio", "--tsProbeLocations", project_library_path, "--ngProbeLocations", project_library_path }

require("lspconfig").angularls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = cmd,
	on_new_config = function(new_config, new_root_dir)
		new_config.cmd = cmd
	end,
})
