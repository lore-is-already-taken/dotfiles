# NixOS Configuration

A comprehensive NixOS configuration featuring flakes, Home Manager integration, and specialized modules for development and cybersecurity work.

## 🏗️ Architecture Overview

This configuration uses **NixOS Flakes** with **Home Manager** to provide a reproducible, declarative system setup. The configuration is modularized into specialized components for maintainability and organization.

### Core Components

- **Flake-based configuration** using NixOS 25.05 stable channel
- **Home Manager integration** for user-specific package management
- **Modular design** with separated concerns (NVIDIA, hacking tools, etc.)
- **Hardware-specific optimizations** for Intel CPU + NVIDIA GPU laptops

## 📁 File Structure

```
nixos/
├── flake.nix                 # Main flake configuration and inputs
├── configuration.nix         # Core system configuration
├── home.nix                  # Home Manager user configuration
├── hardware-configuration.nix # Auto-generated hardware settings
├── nvidia.nix               # NVIDIA GPU configuration module
├── hacking.nix              # Cybersecurity tools configuration
├── flake.lock               # Pinned dependency versions
└── hydra.restore           # System restore point
```

## ⚙️ Configuration Breakdown

### 🔧 Main System (`configuration.nix`)

**Core Features:**
- **Desktop Environment**: Pantheon DE with Qtile window manager
- **Display Manager**: LightDM with X11 support
- **Graphics**: Full NVIDIA driver support with PRIME offloading
- **Audio**: PipeWire with ALSA/Pulse compatibility
- **Networking**: NetworkManager with WiFi firmware support
- **Virtualization**: Docker + QEMU/KVM with virt-manager
- **Security Tools**: Comprehensive cybersecurity toolkit

**Key System Packages:**
- **Development**: Neovim, Arduino IDE, Docker, various language servers
- **Desktop Apps**: Firefox, Chrome, Brave, Discord, Spotify, Obsidian
- **Terminal Tools**: Kitty, Zsh, LSD, Bat, Htop, Tree, Ripgrep
- **Security Tools**: Nmap, Wireshark, Burp Suite, Metasploit, Ghidra, and more

**System Services:**
- Docker daemon with user access
- QEMU/KVM virtualization with OVMF UEFI
- OpenVPN3 support
- CUPS printing service

### 🏠 Home Manager (`home.nix`)

**User-Specific Configuration:**
- **Development Environment**: Node.js 24, Go, Rust (Cargo), Bun
- **Language Servers**: TypeScript, Lua, Go, Nix (nil), C/C++
- **Code Formatting**: Prettier, Stylua, nixpkgs-fmt
- **Neovim Setup**: Comprehensive LSP and tooling integration
- **Shell Environment**: Git configuration, environment variables

**Modular Imports:**
- `nvidia.nix`: NVIDIA-specific Home Manager configuration
- `hacking.nix`: Cybersecurity tools and aliases

### 🎮 NVIDIA Configuration (`nvidia.nix`)

**Hardware Acceleration:**
- **PRIME Offloading**: Intel integrated + NVIDIA discrete GPU setup
- **Driver Configuration**: Stable NVIDIA drivers with modesetting
- **Monitoring Tools**: nvtop, nvidia-system-monitor-qt, GPU viewer
- **Environment Variables**: Proper NVIDIA rendering offload setup
- **Desktop Integration**: NVIDIA Settings and System Monitor launchers

**Useful Aliases:**
- `nv-smi`: nvidia-smi quick access
- `gpu-temp`: Check GPU temperature
- `gpu-usage`: Monitor GPU utilization
- `nv-top`: Real-time GPU monitoring

### 🔐 Security Tools (`hacking.nix`)

**Network Analysis:**
- **Scanning**: Nmap, Netcat, TCPdump
- **Traffic Analysis**: Wireshark with GUI integration
- **Web Testing**: Dirb, Gobuster, Nikto

**Penetration Testing:**
- **Frameworks**: Metasploit, Burp Suite
- **Password Attacks**: John the Ripper, Hashcat, Hydra
- **Wireless**: Aircrack-ng suite

**Binary Analysis:**
- **Reverse Engineering**: Ghidra, Radare2
- **Forensics**: Binwalk, Hexdump, Steghide
- **Development**: Python 3 with security libraries

**Pre-configured Aliases:**
- `nmap-quick`: Fast port scan
- `gobuster-dir`: Directory enumeration
- `tcpdump-http`: HTTP traffic capture
- `hexdump-canonical`: Canonical hex dump format

### 💾 Hardware Support (`hardware-configuration.nix`)

**Auto-Generated Hardware Configuration:**
- **CPU**: Intel with KVM support and microcode updates
- **Storage**: NVMe SSD with ext4 root filesystem
- **Boot**: UEFI with systemd-boot loader
- **Interfaces**: USB 3.0, SD card reader support

## 🚀 Usage Commands

### System Management

```bash
# Rebuild and switch to new configuration
sudo nixos-rebuild switch --flake /home/ivn/repos/dotfiles/nixos#nixos

# Test configuration without switching
sudo nixos-rebuild test --flake /home/ivn/repos/dotfiles/nixos#nixos

# Build configuration without activating
sudo nixos-rebuild build --flake /home/ivn/repos/dotfiles/nixos#nixos

# Update flake inputs
nix flake update

# Show system generation history
nixos-rebuild list-generations
```

### Development Workflow

```bash
# Enter development shell (from repository root)
nix-shell nix-shells/dev.nix

# Update Home Manager
home-manager switch --flake /home/ivn/repos/dotfiles/nixos#ivn

# Check flake status
nix flake check
```

## 🔧 Customization Guide

### Adding New Packages

**System-wide packages** (`configuration.nix`):
```nix
environment.systemPackages = with pkgs; [
  # Add your packages here
  new-package
];
```

**User packages** (`home.nix`):
```nix
home.packages = with pkgs; [
  # Add your packages here
  new-user-package
];
```

### Creating New Modules

1. Create a new `.nix` file (e.g., `custom-tools.nix`)
2. Add the module structure:
```nix
{ config, pkgs, ... }:
{
  # Configuration goes here
}
```
3. Import in `home.nix`:
```nix
imports = [
  ./custom-tools.nix
];
```

### Modifying NVIDIA Settings

Edit `nvidia.nix` for NVIDIA-specific configurations:
- Add new GPU monitoring tools
- Modify PRIME offload settings
- Add CUDA development packages

## 🛠️ Troubleshooting

### Common Issues

**Build Failures:**
```bash
# Clean build cache
nix-collect-garbage
sudo nix-collect-garbage -d

# Rebuild with verbose output
sudo nixos-rebuild switch --flake . --show-trace
```

**Home Manager Conflicts:**
```bash
# Remove conflicting files
rm ~/.config/conflicting-file
home-manager switch --flake .
```

**NVIDIA Issues:**
- Check PRIME bus IDs in `configuration.nix:48-49`
- Verify driver compatibility with `nvidia-smi`
- Monitor GPU usage with `nvtop`

### Useful Debugging Commands

```bash
# Check system logs
journalctl -xe

# Monitor system resources
htop

# Test NVIDIA setup
nvidia-smi
glxinfo | grep NVIDIA

# Verify Home Manager packages
home-manager packages
```

## 🌟 Features Highlights

- **🔄 Reproducible Builds**: Flake lock ensures consistent environments
- **🏠 User Isolation**: Home Manager separates user and system configs
- **🎮 Gaming Ready**: Steam, NVIDIA drivers with PRIME offloading
- **🔒 Security Focused**: Comprehensive pentesting toolkit
- **💻 Development Friendly**: Multiple language support with LSPs
- **🖥️ Desktop Complete**: Modern DE with tiling WM option
- **🐳 Container Ready**: Docker with compose support
- **🌐 Network Tools**: VPN, networking utilities included

## 📋 System Specifications

- **OS**: NixOS 25.05 (stable)
- **Architecture**: x86_64-linux
- **CPU**: Intel with KVM virtualization
- **GPU**: NVIDIA (with Intel integrated graphics)
- **Desktop**: Pantheon + Qtile
- **Shell**: Zsh with custom configuration
- **Editor**: Neovim with LazyVim framework

This configuration provides a complete, professional development and cybersecurity workstation built on NixOS's declarative principles.