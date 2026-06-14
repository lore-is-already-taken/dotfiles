-- This file contains the configuration for disabling specific Neovim plugins.

return {
  {
    -- Plugin: bufferline.nvim
    -- URL: https://github.com/akinsho/bufferline.nvim
    -- Description: A snazzy buffer line (with tabpage integration) for Neovim.
    "akinsho/bufferline.nvim",
    enabled = false, -- Disable this plugin
  },
  {
    "tris203/precognition.nvim",
    enabled = false,
  },
  {
    -- Plugin: claude-code.nvim
    -- URL: https://github.com/greggh/claude-code.nvim
    -- Description: Neovim integration for Claude Code AI assistant.
    -- Disabled: conflicts with coder/claudecode.nvim (both define :ClaudeCode).
    -- We use coder/claudecode.nvim (see plugins/claude-code.lua).
    "greggh/claude-code.nvim",
    enabled = false,
  },
}
