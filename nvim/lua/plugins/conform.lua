return {
  "stevearc/conform.nvim",
  opts = {
    formatters = {
      -- Never reflow prose in markdown: keep one paragraph = one physical line.
      prettier = {
        prepend_args = { "--prose-wrap", "preserve" },
      },
    },
  },
}
