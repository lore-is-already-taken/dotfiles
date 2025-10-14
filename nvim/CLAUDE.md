# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Architecture Overview

This is a **LazyVim-based Neovim configuration** ("GentlemanNvim") that extends LazyVim with custom plugins and AI integrations. The configuration follows LazyVim's structure with organized plugin modules.

### Core Structure

- **Entry Point**: `init.lua` configures Node.js before loading plugins via `lua/config/lazy.lua`
- **Plugin Manager**: Uses lazy.nvim with automatic installation
- **Configuration Layer**: Core config in `lua/config/`, custom plugins in `lua/plugins/`
- **LazyVim Extras**: Imports specific LazyVim modules for editor, language support, formatting, linting, and AI features

### Key Design Patterns

1. **Plugin Configuration Pattern**: Each plugin gets its own file in `lua/plugins/` that returns a table with plugin spec
2. **Overrides Pattern**: `lua/plugins/overrides.lua` modifies existing LazyVim plugin configurations
3. **LazyVim Extension Model**: Uses LazyVim as base, importing extras selectively and overriding via plugin files
4. **Node.js Management**: Custom Node.js configuration module ensures system-wide Node (v18+) is used, not project-specific versions

## Node.js Configuration

The config includes a sophisticated Node.js management system (`lua/config/nodejs.lua`) that:
- Ensures Neovim uses system Node.js (not project-specific versions) to avoid compatibility issues
- Requires Node.js v18+ (v22+ recommended)
- Supports multiple Node managers: Homebrew, Volta, NVM, Nix
- Provides helpful upgrade instructions when Node.js is outdated

**Commands**:
- `:NodeInfo` - Show current Node.js configuration
- `:NodeRefresh` - Refresh Node.js configuration
- `:NodeDebug` - Debug Node.js PATH issues

## AI/LLM Integration

This config has **extensive AI integration** with multiple providers:

### Primary AI Plugins

1. **Claude Code** (`lua/plugins/claude-code.lua`)
   - Terminal splits on left (30% width), using Snacks provider
   - Keybindings under `<leader>a` prefix

2. **CodeCompanion** (`lua/plugins/code-companion.lua`)
   - **Status**: Disabled by default (see `lua/plugins/disabled.lua`)
   - Uses Copilot as default adapter
   - Custom adapters: `copilot_4o`, `copilot_41`, `copilot_gemini_25_pro`
   - Tool groups: `full_stack_dev`, `gentleman` (custom persona)
   - Chat window positioned left
   - Slash command `/git_files` lists git files
   - Custom notifier module at `lua/plugins/codecompanion/codecompanion-notifier.lua`

3. **Avante** (`lua/plugins/avante.lua`)
   - **Status**: Disabled by default (see `lua/plugins/disabled.lua`)
   - Uses Copilot with Claude Sonnet 4 model
   - Sidebar position: left, width 30%
   - Custom system prompt with Spanish/Argentine developer persona
   - Includes complex VimResized handling to prevent window duplication issues
   - File selector uses Snacks provider

4. **OpenCode** (`lua/plugins/opencode.lua`)
   - **Status**: Disabled by default (see `lua/plugins/disabled.lua`)
   - Alternative AI coding assistant
   - Position: left side
   - Includes sophisticated VimResized handling to prevent duplicate windows
   - Keybindings under `<leader>a` prefix (when enabled)
   - Supports diff viewing and session management

5. **Copilot/Copilot Chat**
   - **CopilotChat Status**: Disabled by default (see `lua/plugins/disabled.lua`)
   - Copilot disabled for: yaml, markdown, help, git-related filetypes (`lua/plugins/copilot.lua`)

### Shared Persona

CodeCompanion and Avante share a detailed Spanish-language system prompt defining a "Gentleman" persona: an Argentine frontend architect specializing in Angular/React, Clean Architecture, and developer productivity tools.

## Language & Tool Support

**Languages** (via LazyVim extras):
- TypeScript, Angular, Astro, Go, Nix, JSON, Markdown, TOML

**Formatting**: Biome, Prettier

**Linting**: ESLint

**LSP Configuration** (`lua/plugins/overrides.lua`):
- Angular LS: Custom root detection for `angular.json` or `project.json`
- Nix LS (`nil_ls`): Managed outside Mason, uses `nixpkgs-fmt` for formatting
- Inlay hints: Disabled globally

## Custom Keymaps

Major custom keybindings (`lua/config/keymaps.lua`):

- **Tmux Integration**: `<C-h/j/k/l>` for tmux-aware navigation
- **AI Shortcuts**: `<leader>a` prefix (see AI plugins)
- **Obsidian**: `<leader>o` prefix for note management
- **Oil.nvim**: `-` opens parent directory
- **Buffer Management**: `<leader>bq` deletes all buffers except current
- **Visual Grep**: `<leader>sg` greps selected text (uses Snacks or fzf-lua)
- **Visual Grep Root**: `<leader>sG` greps at repository root
- **Save**: `<C-s>` saves with custom notification
- **Screenkey**: `<leader>uk` toggles screenkey
- **Rip Substitute**: `<leader>fs` opens ripgrep-based find and replace

Disabled: `<A-j>`, `<A-k>` in insert/normal/visual modes

## Important Configuration Details

### Clipboard
- Uses system clipboard (`unnamedplus`)
- WSL support with `win32yank.exe`

### Spell Checking
- Enabled globally for English (`en`)

### Timeout Settings
- `timeoutlen`: 1000ms
- `ttimeoutlen`: 0ms

### LazyVim Settings
- Colorschemes: tokyonight (primary), habamax (fallback)
- Auto-check for plugin updates enabled
- Custom plugins NOT lazy-loaded by default
- Performance: Disables gzip, tar, zip, tutor, tohtml plugins

## Development Workflow

This is a **personal configuration repository**, not a traditional codebase with tests/builds. Changes are made directly to Lua configuration files.

**Typical Tasks**:
1. Adding new plugins: Create file in `lua/plugins/`
2. Modifying existing LazyVim plugins: Edit `lua/plugins/overrides.lua`
3. Custom keymaps: Add to `lua/config/keymaps.lua`
4. Global options: Edit `lua/config/options.lua`
5. Autocommands: Edit `lua/config/autocmds.lua`

**Testing Changes**: Restart Neovim (`:qa` then reopen) or use `:Lazy reload <plugin-name>`

**Plugin Management**:
- `:Lazy` - Open lazy.nvim UI
- `:Lazy update` - Update all plugins
- `:Lazy sync` - Install missing + update + clean plugins

## Notable Plugins

Beyond the AI integrations and core LazyVim setup, this config includes:

- **Smear Cursor** (`lua/plugins/smear.lua`): Smooth cursor animations
- **Precognition** (`lua/plugins/precognition.lua`): Shows vim motion hints (disabled by default)
- **Screenkey** (`lua/plugins/screenkey.lua`): Display keypresses on screen (useful for demos/recordings)
- **Vim-be-good** (`lua/plugins/vim-be-good.lua`): Vim skill training game
- **Twilight** (`lua/plugins/twilight.lua`): Dim inactive code sections
- **Rip Substitute** (`lua/plugins/rip.lua`): Ripgrep-based search and replace
- **Multi-line** (`lua/plugins/multi-line.lua`): Multiple cursor support

### Plugin Management via `disabled.lua`

The config uses `lua/plugins/disabled.lua` to control which AI plugins are active. By default:
- **Enabled**: Claude Code
- **Disabled**: Avante, CodeCompanion, CopilotChat, OpenCode, Precognition

To enable a plugin, change `enabled = false` to `enabled = true` in `disabled.lua`.

## File Organization

```
nvim/
├── init.lua                      # Entry point
├── lazy-lock.json                # Plugin version lock file
├── lazyvim.json                  # LazyVim metadata
├── CLAUDE.md                     # This file
├── lua/
│   ├── config/
│   │   ├── autocmds.lua         # Autocommands
│   │   ├── keymaps.lua          # Custom keybindings
│   │   ├── lazy.lua             # Lazy.nvim bootstrap + LazyVim setup
│   │   ├── nodejs.lua           # Node.js configuration module
│   │   ├── options.lua          # Global options
│   │   └── gentleman/
│   │       └── utils.lua        # Color utility functions (hex/RGB/HSL)
│   └── plugins/
│       ├── avante.lua           # Avante AI plugin (disabled)
│       ├── blink.lua            # Blink completion
│       ├── claude-code.lua      # Claude Code integration
│       ├── code-companion.lua   # CodeCompanion AI (disabled)
│       ├── codecompanion/
│       │   └── codecompanion-notifier.lua  # Custom notifier
│       ├── copilot.lua          # Copilot config
│       ├── copilot-chat.lua     # Copilot Chat (disabled)
│       ├── colorscheme.lua      # Theme config
│       ├── disabled.lua         # Plugin enable/disable control
│       ├── editor.lua           # Editor plugins
│       ├── fzflua.lua           # Fuzzy finder
│       ├── gemini.lua           # Gemini integration (commented out)
│       ├── markdown.lua         # Markdown support
│       ├── multi-line.lua       # Multiple cursors
│       ├── nvim-dap.lua         # Debug adapter
│       ├── obsidian.lua         # Obsidian integration
│       ├── oil.lua              # File explorer
│       ├── opencode.lua         # OpenCode AI (disabled)
│       ├── overrides.lua        # LazyVim overrides
│       ├── precognition.lua     # Vim motion hints (disabled)
│       ├── rip.lua              # Ripgrep substitute
│       ├── screenkey.lua        # Keypress display
│       ├── smear.lua            # Smooth cursor
│       ├── twilight.lua         # Dim inactive code
│       ├── ui.lua               # UI plugins
│       ├── vim-be-good.lua      # Vim training
│       ├── vim-tmux-navigation.lua  # Tmux integration
│       └── which-key.lua        # Keybinding helper
```

## Important Implementation Details

### VimResized Event Handling

Multiple AI plugins (Avante, OpenCode) include **custom VimResized autocmd handlers** to prevent window duplication issues. These handlers:
- Temporarily move cursor away from AI windows during resize
- Clean up duplicate windows after resize completes
- Use deferred execution with timing delays
- Track internal state to prevent event loops

**When modifying AI plugins**: Be cautious with VimResized events - the custom handlers are necessary workarounds for plugin behavior that creates duplicate windows on terminal resize.

## Notes for AI Assistants

- This is a personal Neovim config, not a software project with conventional tests/CI
- Changes should maintain LazyVim compatibility
- Plugin configurations follow lazy.nvim spec format
- Custom system prompts are intentionally in Spanish (user preference)
- Node.js management is critical for LSP functionality - don't modify without understanding the implications
- The user has a strong preference for modular, well-organized configuration files
- Most AI plugins are disabled by default - only Claude Code is enabled. Check `disabled.lua` before assuming a plugin is active
- When adding or modifying AI plugins, consider whether VimResized handling is needed to prevent window duplication