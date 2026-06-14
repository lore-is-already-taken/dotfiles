-- This file contains the configuration for the vim-visual-multi plugin in Neovim.

return {
  {
    -- Plugin: vim-visual-multi
    -- URL: https://github.com/mg979/vim-visual-multi
    -- Description: Multiple cursors / simultaneous editing. Modern successor to the
    -- deprecated terryma/vim-multiple-cursors.
    "mg979/vim-visual-multi",
    branch = "master",
    event = "VeryLazy",
    init = function()
      -- Use the default leader; <C-n> selects the word under cursor / next match.
      vim.g.VM_maps = {
        ["Find Under"] = "<C-n>",
        ["Find Subword Under"] = "<C-n>",
      }
    end,
  },
}
