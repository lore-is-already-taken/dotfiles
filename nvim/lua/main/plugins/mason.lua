-- lua/plugins/mason.lua
return {
  {

    "williamboman/mason.nvim",
    version = "1.11.0", -- Your version pin
    opts = function(_, opts)
      -- This function modifies the default mason.nvim options.

      -- We will define a list of all packages we want to PREVENT from being installed.
      local packages_to_ignore = {
        "lua-language-server",
        "stylua", -- Add stylua to our ignore list
      }

      -- We create a new 'ensure_installed' list, filtering out the packages we want to ignore.
      local new_ensure_installed = {}
      for _, pkg in ipairs(opts.ensure_installed) do
        local should_ignore = false
        for _, pkg_to_ignore in ipairs(packages_to_ignore) do
          if pkg == pkg_to_ignore then
            should_ignore = true
            break
          end
        end

        if not should_ignore then
          table.insert(new_ensure_installed, pkg)
        end
      end

      opts.ensure_installed = new_ensure_installed
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    version = "1.32.0", -- Your version pin
  },
}
