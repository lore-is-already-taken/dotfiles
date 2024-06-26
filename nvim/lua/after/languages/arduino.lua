local lsp_helpers = require("after.languages.lsp")
local on_attach = lsp_helpers.on_attach

require("lspconfig").arduino_language_server.setup({
	on_attach = on_attach,
	capabilities = {
		general = {
			positionEncodings = { "utf-16" },
		},
		textDocument = {
			callHierarchy = {
				dynamicRegistration = false,
			},
			codeAction = {
				codeActionLiteralSupport = {
					codeActionKind = {
						valueSet = {
							"",
							"quickfix",
							"refactor",
							"refactor.extract",
							"refactor.inline",
							"refactor.rewrite",
							"source",
							"source.organizeImports",
						},
					},
				},
				dataSupport = true,
				dynamicRegistration = true,
				isPreferredSupport = true,
				resolveSupport = {
					properties = { "edit" },
				},
			},
			completion = {
				completionItem = {
					commitCharactersSupport = false,
					deprecatedSupport = false,
					documentationFormat = { "markdown", "plaintext" },
					preselectSupport = false,
					snippetSupport = false,
				},
				completionItemKind = {
					valueSet = {
						1,
						2,
						3,
						4,
						5,
						6,
						7,
						8,
						9,
						10,
						11,
						12,
						13,
						14,
						15,
						16,
						17,
						18,
						19,
						20,
						21,
						22,
						23,
						24,
						25,
					},
				},
				completionList = {
					itemDefaults = { "editRange", "insertTextFormat", "insertTextMode", "data" },
				},
				contextSupport = false,
				dynamicRegistration = false,
			},
			declaration = {
				linkSupport = true,
			},
			definition = {
				dynamicRegistration = true,
				linkSupport = true,
			},
			diagnostic = {
				dynamicRegistration = false,
			},
			documentHighlight = {
				dynamicRegistration = false,
			},
			documentSymbol = {
				dynamicRegistration = false,
				hierarchicalDocumentSymbolSupport = true,
				symbolKind = {
					valueSet = {
						1,
						2,
						3,
						4,
						5,
						6,
						7,
						8,
						9,
						10,
						11,
						12,
						13,
						14,
						15,
						16,
						17,
						18,
						19,
						20,
						21,
						22,
						23,
						24,
						25,
						26,
					},
				},
			},
			formatting = {
				dynamicRegistration = true,
			},
			hover = {
				contentFormat = { "markdown", "plaintext" },
				dynamicRegistration = true,
			},
			implementation = {
				linkSupport = true,
			},
			inlayHint = {
				dynamicRegistration = true,
				resolveSupport = {
					properties = { "textEdits", "tooltip", "location", "command" },
				},
			},
			publishDiagnostics = {
				dataSupport = true,
				relatedInformation = true,
				tagSupport = {
					valueSet = { 1, 2 },
				},
			},
			rangeFormatting = {
				dynamicRegistration = true,
			},
			references = {
				dynamicRegistration = false,
			},
			rename = {
				dynamicRegistration = true,
				prepareSupport = true,
			},
			semanticTokens = vim.NIL,
			signatureHelp = {
				dynamicRegistration = false,
				signatureInformation = {
					activeParameterSupport = true,
					documentationFormat = { "markdown", "plaintext" },
					parameterInformation = {
						labelOffsetSupport = true,
					},
				},
			},
			synchronization = {
				didSave = true,
				dynamicRegistration = false,
				willSave = true,
				willSaveWaitUntil = true,
			},
			typeDefinition = {
				linkSupport = true,
			},
		},
		window = {
			showDocument = {
				support = true,
			},
			showMessage = {
				messageActionItem = {
					additionalPropertiesSupport = false,
				},
			},
			workDoneProgress = true,
		},
		workspace = {
			applyEdit = true,
			configuration = true,
			didChangeConfiguration = {
				dynamicRegistration = false,
			},
			didChangeWatchedFiles = {
				dynamicRegistration = true,
				relativePatternSupport = true,
			},
			inlayHint = {
				refreshSupport = true,
			},
			semanticTokens = vim.NIL,
			symbol = {
				dynamicRegistration = false,
				symbolKind = {
					valueSet = {
						1,
						2,
						3,
						4,
						5,
						6,
						7,
						8,
						9,
						10,
						11,
						12,
						13,
						14,
						15,
						16,
						17,
						18,
						19,
						20,
						21,
						22,
						23,
						24,
						25,
						26,
					},
				},
			},
			workspaceEdit = {
				resourceOperations = { "rename", "create", "delete" },
			},
			workspaceFolders = true,
		},
	},
	filetypes = {
		"arduino",
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
