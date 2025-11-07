# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository containing configuration files for various Linux desktop tools and development environments. The repository is primarily focused on NixOS system configuration, Neovim editor setup, and Qtile window manager configuration.

## Key Directory Structure

- **nixos/**: NixOS system configuration with hardware support and package management
- **nvim/**: LazyVim-based Neovim configuration with extensive plugin setup
- **qtile/**: Python-based tiling window manager configuration with modular settings
- **kitty/**: Terminal emulator configuration
- **nix-shells/**: Development environment shell configurations
- **nix-flakes/**: Experimental Nix flake configurations

## NixOS Configuration

### Main Commands

- **Rebuild system**: `sudo nixos-rebuild switch --flake /home/ivn/repos/dotfiles/nixos#nixos`
- **Test configuration**: `sudo nixos-rebuild test --flake /home/ivn/repos/dotfiles/nixos#nixos`
- **Build without switching**: `sudo nixos-rebuild build --flake /home/ivn/repos/dotfiles/nixos#nixos`

### Architecture

The NixOS configuration (`nixos/flake.nix`) uses the stable 25.05 channel and includes:
- NVIDIA GPU support with proper driver configuration
- Hardware-specific settings from `hardware-configuration.nix`
- Development tools and libraries via nix-ld

## Neovim Configuration

### Architecture

The Neovim setup is built on LazyVim with extensive customization:
- **Base**: LazyVim framework with lazy loading
- **Package Manager**: lazy.nvim for plugin management
- **Language Support**: TypeScript/JavaScript, Go, Nix, Angular, Astro, JSON, Markdown, TOML
- **AI Integration**: GitHub Copilot, Copilot Chat, and various AI coding assistants
- **Formatting**: Prettier, Biome, ESLint integration
- **Code Completion**: Blink cmp for enhanced completion

### Key Configuration Files

- `init.lua`: Entry point, loads Node.js config and LazyVim
- `lua/config/lazy.lua`: Main LazyVim setup and plugin specifications
- `lua/plugins/`: Custom plugin overrides and configurations
- `stylua.toml`: Lua code formatting rules (2 spaces, 120 columns)

### Development Commands

- **Format Lua files**: `stylua .` (from nvim directory)
- **Plugin updates**: `:Lazy sync` (within Neovim)

## Qtile Window Manager

### Architecture

Modular Python configuration split across `qtile/settings/`:
- `config.py`: Main entry point importing all modules
- `keys.py`: Keybinding definitions
- `groups.py`: Workspace/group configuration
- `layouts.py`: Window layout settings
- `screens.py`: Monitor/screen configuration
- `widgets.py`: Status bar widget setup
- `theme.py`: Color scheme management
- `custom_functions.py`: Helper functions

### Theme System

Themes are JSON files in `qtile/themes/` with color definitions for:
- Background colors (dark, grey, light)
- Text and focus colors
- Window state colors (active, inactive, urgent)
- Custom accent colors (color1-4)

### Utility Scripts

- `autostart.sh`: Applications launched at startup
- `screenshot.sh`: Screenshot functionality
- `vpn.sh`: VPN management
- `ip.sh`: Network information display

## Development Environment

### Nix Development Shells

Available in `nix-shells/`:
- `dev.nix`: General development environment
- `sec.nix`: Security-focused tools
- `lmstudio.nix`: LM Studio/AI development

Usage: `nix-shell nix-shells/dev.nix`

## File Modifications

When editing configuration files:
- **NixOS configs**: Require system rebuild to take effect
- **Neovim configs**: Reload with `:source %` or restart Neovim
- **Qtile configs**: Reload with `Mod+Ctrl+r` or restart Qtile
- **Lua files**: Follow stylua formatting (2 spaces, 120 char width)
- **Python files**: Follow existing code style in qtile modules

## Important Notes

- The repository uses Git for version control with a clean working directory
- NixOS configuration targets x86_64-linux systems with NVIDIA graphics
- Neovim setup requires Node.js for LSP and plugin functionality
- Qtile configuration assumes Linux desktop environment with X11/Wayland support