return {
  {
    "folke/trouble.nvim",
    opts = { use_diagnostic_signs = true },
  },

  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
    config = true,
  },

  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.inlay_hints = vim.tbl_deep_extend("force", opts.inlay_hints or {}, { enabled = false })

      opts.servers = opts.servers or {}
      opts.servers.angularls = {
        root_dir = function(fname)
          return require("lspconfig.util").root_pattern("angular.json", "project.json")(fname)
        end,
      }
      opts.servers.nil_ls = {
        -- nil is installed via Nix (not Mason); format with nixpkgs-fmt on save
        cmd = { "nil" },
        autostart = true,
        mason = false,
        settings = {
          ["nil"] = { formatting = { command = { "nixpkgs-fmt" } } },
        },
      }

      -- Drop the gopls semantic-tokens workaround shipped with the lang/go
      -- extra: it reads client.config.capabilities.textDocument, which is nil
      -- under the new vim.lsp.config / vim.lsp.enable flow in LazyVim 15.x.
      -- Modern gopls exposes semanticTokensProvider natively.
      opts.setup = opts.setup or {}
      opts.setup.gopls = function() end
    end,
  },

  -- Go: real tabs (gofmt/gofumpt convention) shown as 4 columns.
  -- LazyVim defaults to tabstop=2, shiftwidth=2, expandtab=true which fights
  -- the formatter on save. The augroup makes this safe across :Lazy reload.
  {
    "LazyVim/LazyVim",
    opts = function()
      local group = vim.api.nvim_create_augroup("go_filetype", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        group = group,
        pattern = "go",
        callback = function()
          vim.opt_local.tabstop = 4
          vim.opt_local.shiftwidth = 4
          vim.opt_local.expandtab = false
        end,
      })
    end,
  },
}
