local lsp_helpers = require("after.languages.lsp")
local on_attach = lsp_helpers.on_attach

--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true


require("lspconfig").arduino_language_server.setup({
	on_attach = on_attach,
    capabilities=capabilities,
	filetypes = {
		"arduino",
        "cpp"
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
