require("mason").setup()

require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
        --"Black",
        "pyright",
        "tsserver",
        "emmet_ls",
        "biome",
        --"mypy",
        --"ruff",
        --"ast-grep",
        --"isort",
        --"stylua",
        --"debugpy",
        --"prettier",
        --"prettierd",
    },
})
