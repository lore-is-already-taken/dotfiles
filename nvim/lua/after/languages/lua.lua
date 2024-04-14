local lsp_helpers = require("after.languages.lsp")
local on_attach = lsp_helpers.on_attach

require("lspconfig").lua_ls.setup({
	on_attach = on_attach,
	settings = {
		Lua = {
			telemetry = { enable = true },
			workspace = { checkThirdParty = true },
		},
	},
})
