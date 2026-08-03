return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      python = { "ruff_format", "ruff_organize_imports" },
    },
    formatters = {
      -- Never reflow prose in markdown: keep one paragraph = one physical line.
      prettier = {
        prepend_args = { "--prose-wrap", "preserve" },
      },
    },
  },
}
