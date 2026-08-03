-- Terragrunt support.
--
-- terraform-ls does NOT understand Terragrunt's own blocks (include, dependency,
-- generate, terraform { source = ... }) and floods .hcl files with false
-- diagnostics, so we use gruntwork-io/terragrunt-ls instead — the official LSP
-- that parses config with Terragrunt itself.
--
-- Install (not on Mason; it's a Go binary with replace directives in go.mod, so
-- `go install ...@latest` fails — build from the repo root):
--   git clone --depth 1 https://github.com/gruntwork-io/terragrunt-ls
--   cd terragrunt-ls && go install .
-- Produces ~/go/bin/terragrunt-ls.
--
-- Features today (v0.0.x, work in progress): diagnostics, hover on locals,
-- go-to-definition on includes, block/attribute completion, and formatting.
return {
  -- HCL syntax highlighting for terragrunt.hcl / root.hcl / *.hcl files.
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "hcl" } },
  },

  -- The lang.terraform extra sets conform's hcl formatter to packer_fmt, which
  -- would try to run `packer fmt` on terragrunt.hcl files. We don't want that:
  -- clear it so hcl falls back to terragrunt-ls LSP formatting instead.
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        hcl = {},
      },
    },
  },

  -- Enable the Terragrunt language server. nvim-lspconfig already ships the
  -- base config (cmd, filetypes = { "hcl" }, root_markers). We only override
  -- cmd with an absolute path because ~/go/bin is not on PATH, and disable
  -- Mason since this server is installed manually.
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        terragrunt_ls = {
          cmd = { vim.fn.expand("~/go/bin/terragrunt-ls") },
          mason = false,
        },
      },
    },
  },
}
