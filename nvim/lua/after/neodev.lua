local on_attach = function(_, bufnr)
	vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
	-- Buffer local mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local opts = { buffer = bufnr }
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
	--vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
	vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
	vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
end

require("neodev").setup()
-- Checking Lua setup LSP
require("lspconfig").lua_ls.setup({
	on_attach = on_attach,
	settings = {
		Lua = {
			telemetry = { enable = false },
			workspace = { checkThirdParty = false },
		},
	},
})

-- Python SETUP LSP
require("lspconfig").pyright.setup({
	on_attach = on_attach,
	settings = {
		filetypes = { "python" },
	},
})

--require("lspconfig").biome.setup({
--    on_attach = on_attach,
--    settings = {
--        filetypes = {
--            "javascript",
--            "javascriptreact",
--            "json",
--            "jsonc",
--            "typescript",
--            "typescript.tsx",
--            "typescriptreact",
--        },
--    },
--})
--require('lspconfig').tsserver.setup({
--    on_attach = on_attach,
--    settings = {
--        filetypes = {
--            "javascript",
--            "javascriptreact",
--            --"json",
--            --"jsonc",
--            "typescript",
--            "typescript.tsx",
--            "typescriptreact",
--        },
--    },
--})
require("lspconfig").eslint.setup({
	on_attach = on_attach,
	settings = {
		filetypes = {
			"javascript",
			"javascriptreact",
			"javascript.jsx",
			"typescript",
			"typescriptreact",
			"typescript.tsx",
			"vue",
			"svelte",
			"astro",
		},
		--codeAction = {
		--    disableRuleComment = {
		--        enable = true,
		--        location = "separateLine",
		--    },
		--    showDocumentation = {
		--        enable = true,
		--    },
		--},
		--codeActionOnSave = {
		--    enable = false,
		--    mode = "all",
		--},
		--experimental = {
		--    useFlatConfig = false,
		--},
		--format = true,
		--nodePath = "",
		--onIgnoredFiles = "off",
		--problems = {
		--    shortenToSingleLine = false,
		--},
		--quiet = false,
		--rulesCustomizations = {},
		--run = "onType",
		--useESLintClass = false,
		--validate = "on",
		--workingDirectory = {
		--    mode = "location",
		--},
	},
	--settings = {
	--    filetypes = {
	--        "javascript",
	--        "javascriptreact",
	--        --"json",
	--        --"jsonc",
	--        "typescript",
	--        "typescript.tsx",
	--        "typescriptreact",
	--    },
	--},
})
require("lspconfig").emmet_ls.setup({
	on_attach = on_attach,
	settings = {
		filetypes = {
			"html",
		},
	},
})

require("lspconfig").arduino_language_server.setup({
	on_attach = on_attach,
	settings = {
		--capabilities = {
		--    general = {
		--        positionEncodings = { "utf-16" },
		--    },
		--    textDocument = {
		--        callHierarchy = {
		--            dynamicRegistration = false,
		--        },
		--        codeAction = {
		--            codeActionLiteralSupport = {
		--                codeActionKind = {
		--                    valueSet = {
		--                        "",
		--                        "quickfix",
		--                        "refactor",
		--                        "refactor.extract",
		--                        "refactor.inline",
		--                        "refactor.rewrite",
		--                        "source",
		--                        "source.organizeImports",
		--                    },
		--                },
		--            },
		--            dataSupport = true,
		--            dynamicRegistration = true,
		--            isPreferredSupport = true,
		--            resolveSupport = {
		--                properties = { "edit" },
		--            },
		--        },
		--        completion = {
		--            completionItem = {
		--                commitCharactersSupport = false,
		--                deprecatedSupport = false,
		--                documentationFormat = { "markdown", "plaintext" },
		--                preselectSupport = false,
		--                snippetSupport = false,
		--            },
		--            completionItemKind = {
		--                valueSet = {
		--                    1,
		--                    2,
		--                    3,
		--                    4,
		--                    5,
		--                    6,
		--                    7,
		--                    8,
		--                    9,
		--                    10,
		--                    11,
		--                    12,
		--                    13,
		--                    14,
		--                    15,
		--                    16,
		--                    17,
		--                    18,
		--                    19,
		--                    20,
		--                    21,
		--                    22,
		--                    23,
		--                    24,
		--                    25,
		--                },
		--            },
		--            completionList = {
		--                itemDefaults = { "editRange", "insertTextFormat", "insertTextMode", "data" },
		--            },
		--            contextSupport = false,
		--            dynamicRegistration = false,
		--        },
		--        declaration = {
		--            linkSupport = true,
		--        },
		--        definition = {
		--            dynamicRegistration = true,
		--            linkSupport = true,
		--        },
		--        diagnostic = {
		--            dynamicRegistration = false,
		--        },
		--        documentHighlight = {
		--            dynamicRegistration = false,
		--        },
		--        documentSymbol = {
		--            dynamicRegistration = false,
		--            hierarchicalDocumentSymbolSupport = true,
		--            symbolKind = {
		--                valueSet = {
		--                    1,
		--                    2,
		--                    3,
		--                    4,
		--                    5,
		--                    6,
		--                    7,
		--                    8,
		--                    9,
		--                    10,
		--                    11,
		--                    12,
		--                    13,
		--                    14,
		--                    15,
		--                    16,
		--                    17,
		--                    18,
		--                    19,
		--                    20,
		--                    21,
		--                    22,
		--                    23,
		--                    24,
		--                    25,
		--                    26,
		--                },
		--            },
		--        },
		--        formatting = {
		--            dynamicRegistration = true,
		--        },
		--        hover = {
		--            contentFormat = { "markdown", "plaintext" },
		--            dynamicRegistration = true,
		--        },
		--        implementation = {
		--            linkSupport = true,
		--        },
		--        inlayHint = {
		--            dynamicRegistration = true,
		--            resolveSupport = {
		--                properties = { "textEdits", "tooltip", "location", "command" },
		--            },
		--        },
		--        publishDiagnostics = {
		--            dataSupport = true,
		--            relatedInformation = true,
		--            tagSupport = {
		--                valueSet = { 1, 2 },
		--            },
		--        },
		--        rangeFormatting = {
		--            dynamicRegistration = true,
		--        },
		--        references = {
		--            dynamicRegistration = false,
		--        },
		--        rename = {
		--            dynamicRegistration = true,
		--            prepareSupport = true,
		--        },
		--        semanticTokens = vim.NIL,
		--        signatureHelp = {
		--            dynamicRegistration = false,
		--            signatureInformation = {
		--                activeParameterSupport = true,
		--                documentationFormat = { "markdown", "plaintext" },
		--                parameterInformation = {
		--                    labelOffsetSupport = true,
		--                },
		--            },
		--        },
		--        synchronization = {
		--            didSave = true,
		--            dynamicRegistration = false,
		--            willSave = true,
		--            willSaveWaitUntil = true,
		--        },
		--        typeDefinition = {
		--            linkSupport = true,
		--        },
		--    },
		--    window = {
		--        showDocument = {
		--            support = true,
		--        },
		--        showMessage = {
		--            messageActionItem = {
		--                additionalPropertiesSupport = false,
		--            },
		--        },
		--        workDoneProgress = true,
		--    },
		--    workspace = {
		--        applyEdit = true,
		--        configuration = true,
		--        didChangeConfiguration = {
		--            dynamicRegistration = false,
		--        },
		--        didChangeWatchedFiles = {
		--            dynamicRegistration = true,
		--            relativePatternSupport = true,
		--        },
		--        inlayHint = {
		--            refreshSupport = true,
		--        },
		--        semanticTokens = vim.NIL,
		--        symbol = {
		--            dynamicRegistration = false,
		--            symbolKind = {
		--                valueSet = {
		--                    1,
		--                    2,
		--                    3,
		--                    4,
		--                    5,
		--                    6,
		--                    7,
		--                    8,
		--                    9,
		--                    10,
		--                    11,
		--                    12,
		--                    13,
		--                    14,
		--                    15,
		--                    16,
		--                    17,
		--                    18,
		--                    19,
		--                    20,
		--                    21,
		--                    22,
		--                    23,
		--                    24,
		--                    25,
		--                    26,
		--                },
		--            },
		--        },
		--        workspaceEdit = {
		--            resourceOperations = { "rename", "create", "delete" },
		--        },
		--        workspaceFolders = true,
		--    },
		--},
	},
})
