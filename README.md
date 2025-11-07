# dotfiles

## NixOS Configuration

This directory contains a flake-based NixOS configuration with Home Manager integration for managing user-specific packages and dotfiles.

### Quick Start

**First-time setup:**
```bash
# 1. Replace hardware configuration with your system's
sudo nixos-generate-config --show-hardware-config > ./nixos/hardware-configuration.nix

# 2. Build and switch to configuration  
sudo nixos-rebuild switch --flake ./nixos#nixos
```

**Regular usage:**
```bash
# Build and switch to configuration
sudo nixos-rebuild switch --flake ./nixos#nixos

# Test configuration without switching
sudo nixos-rebuild test --flake ./nixos#nixos

# Update flake inputs
nix flake update ./nixos
```

### Architecture

- **Flake-based configuration** using NixOS 25.05 stable channel
- **Home Manager integration** for user-specific package management
- **Modular structure** separating system and user configurations

### Key Files

| File                               | Purpose                                          |
| ---------------------------------- | ------------------------------------------------ |
| `nixos/flake.nix`                  | Main flake configuration with inputs and outputs |
| `nixos/configuration.nix`          | System-level NixOS configuration                 |
| `nixos/home.nix`                   | Home Manager user configuration                  |
| `nixos/hardware-configuration.nix` | Hardware-specific settings (replace with your system's) |

### Features

- **NVIDIA GPU support** with proper driver configuration
- **Development environment** managed via Home Manager
- **Qtile window manager** with custom configuration
- **Virtualization support** (Docker, libvirt/QEMU)
- **Security-focused** configuration without system-wide impurities
- **Hardware-agnostic** - uses system's `/etc/nixos/hardware-configuration.nix`

### Home Manager

User-specific packages and configurations are managed through Home Manager:

- Neovim with language servers and development tools
- Development packages (Node.js, Go, Rust, etc.)
- Git configuration
- XDG directory management

### Documentation

- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [Home Manager Manual](https://nix-community.github.io/home-manager/)
- [Nix Flakes](https://nixos.wiki/wiki/Flakes)
- [NixOS Options Search](https://search.nixos.org/options)

### Troubleshooting

**Common Issues:**

- **Dirty git tree warnings**: Normal during development, commit changes or use `--impure` flag
- **Home Manager conflicts**: Existing dotfiles may conflict, check service logs with `journalctl -u home-manager-ivn.service`
- **Build failures**: Ensure all files are committed to git as flakes require clean working directory

**Useful Commands:**

```bash
# Check flake syntax and build
nix flake check ./nixos

# Show flake info
nix flake show ./nixos

# Build without switching
nixos-rebuild build --flake ./nixos#nixos
```

