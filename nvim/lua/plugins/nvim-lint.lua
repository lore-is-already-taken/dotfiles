return {
  "mfussenegger/nvim-lint",
  opts = function(_, opts)
    -- Point markdownlint-cli2 at our global config so MD013 stays disabled
    -- everywhere, regardless of the project's cwd. Keep stdin ("-").
    local config = vim.fn.stdpath("config") .. "/markdownlint.yaml"
    opts.linters = opts.linters or {}
    opts.linters["markdownlint-cli2"] = {
      args = { "--config", config, "-" },
    }
    return opts
  end,
}
