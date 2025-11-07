{ config, pkgs, ... }:

{
  imports = [
    ./nvidia.nix
    ./hacking.nix
  ];
  # Home Manager needs a bit of information about you and the paths it should manage
  home.username = "ivn";
  home.homeDirectory = "/home/ivn";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  home.stateVersion = "25.05";

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

  # Development packages that need dynamic linking
  home.packages = with pkgs; [
    # Development tools (neovim configured separately below)
    nodejs_24
    
    # Development dependencies that might need dynamic linking
    cargo
    luarocks
    
    # Language servers and tools for Neovim
    nil # Nix LSP
    clang-tools
    arduino-language-server
    
    # Additional development tools from dev.nix
    gnumake
    nixpkgs-fmt
    lemminx
    luajitPackages.lua-lsp
    
    # Additional development tools
    go
    bun
  ];

  # Programs configuration
  programs = {
    # Git configuration
    git = {
      enable = true;
      # You can add your git config here if needed
    };

    # Zsh configuration disabled to avoid conflicts with existing .zshrc
    # zsh = {
    #   enable = true;
    #   # Add zsh configuration here if needed
    # };

    # Neovim configuration with dynamic linking support
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      
      # This allows Neovim to find and run binaries like language servers
      extraPackages = with pkgs; [
        # Language servers
        nodePackages.typescript-language-server
        nodePackages.vscode-langservers-extracted
        lua-language-server
        gopls
        nil
        
        # Formatters
        nodePackages.prettier
        stylua
        lazygit
        
        # Other tools Neovim might need
        ripgrep
        fd
        viu
        chafa
        ueberzugpp
        tree-sitter
      ];
    };
  };

  # Environment variables for development
  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "firefox";
  };

  # XDG configuration
  xdg.enable = true;
}
