local lsp_helpers = require("after.languages.lsp")
local on_attach = lsp_helpers.on_attach

--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local MY_FQBN = "esp32:esp32:esp32"

require("lspconfig").arduino_language_server.setup({
	on_attach = on_attach,
	capabilities = {
		textDocument = {
			semanticTokens = vim.NIL,
		},
		workspace = {
			semanticTokens = vim.NIL,
		},
		capabilities = capabilities,
	},
	cmd = {
		"/etc/profiles/per-user/ivn/bin/arduino-language-server",
		"-clangd",
		"/etc/profiles/per-user/ivn/bin/clangd",
		"-cli",
		"/etc/profiles/per-user/ivn/bin/arduino-cli",
		"-cli-config",
		"$HOME/.arduino15/arduino-cli.yaml",
		"-fqbn",
		MY_FQBN,
	},
})
require("lspconfig").clangd.setup({

	on_attach = on_attach,
	capabilities = capabilities,
	cmd = { "clangd", "--compile-commands-dir=" .. vim.loop.cwd() },
	filetypes = { "c", "cpp", "objc", "objcpp", "arduino" },
	init_options = {
		usePlaceholders = true,
		completeUnimported = true,
	},
})

--arduino-cli board attach -p /dev/ttyACM0 -b arduino:avr:uno test.ino
vim.api.nvim_buf_set_keymap(0, "n", "<leader>aa", ":ArduinoAttach<CR>", {})
vim.api.nvim_buf_set_keymap(0, "n", "<leader>av", ":ArduinoVerify<CR>", {})
vim.api.nvim_buf_set_keymap(0, "n", "<leader>au", ":ArduinoUpload<CR>", {})
vim.api.nvim_buf_set_keymap(0, "n", "<leader>aus", ":ArduinoUploadAndSerial<CR>", {})
vim.api.nvim_buf_set_keymap(0, "n", "<leader>aaa", ":ArduinoSerial<CR>", {})
vim.api.nvim_buf_set_keymap(0, "n", "<leader>ab", ":ArduinoChooseBoard<CR>", {})
vim.api.nvim_buf_set_keymap(0, "n", "<leader>ap", ":ArduinoChooseProgrammer<CR>", {})
