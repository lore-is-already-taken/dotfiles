# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  ## nvidia config
  # Enable OpenGL
  #
  boot.kernelModules = [ "nvidia_uvm" "nvidia_modeset" "nvidia_drm" "nvidia" ];
  boot.kernelParams = [ "nvidia-drm.modeset=1" ];

  hardware.graphics = {
    enable = true;
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc # Provides the C compiler libraries
    glibc # Provides basic C libraries
    zlib # Often needed by build scripts
  ];
  hardware.nvidia = {

    modesetting.enable = true;
    open = false;
    nvidiaSettings = true;


    powerManagement = {
      enable = false;
      finegrained = false;
    };
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    # Explicitly specify the package

    ### Prime configuration for laptops
    prime = {
      offload.enable = true; # Enable on-demand mode
      # Enable if you want to use the integrated GPU for the display
      # and only use nvidia for specific applications
      intelBusId = "PCI:0:2:0"; # You'll need to verify this value
      nvidiaBusId = "PCI:2:0:0"; # You'll need to verify this value
    };
  };

  ## end nvidia config

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  networking.extraHosts = "10.10.11.32 sightless.htb sqlpad.sightless.htb";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Santiago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_CL.UTF-8";
    LC_IDENTIFICATION = "es_CL.UTF-8";
    LC_MEASUREMENT = "es_CL.UTF-8";
    LC_MONETARY = "es_CL.UTF-8";
    LC_NAME = "es_CL.UTF-8";
    LC_NUMERIC = "es_CL.UTF-8";
    LC_PAPER = "es_CL.UTF-8";
    LC_TELEPHONE = "es_CL.UTF-8";
    LC_TIME = "es_CL.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.gvfs.enable = true;

  # Enable Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];


  # Enable Docker
  virtualisation.docker.enable = true;

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  virtualisation.libvirtd.qemu = {
    package = pkgs.qemu_kvm;
    ovmf = {
      enable = true;
      packages = [ pkgs.OVMFFull.fd ];
    };
  };


  programs.openvpn3.enable = true;
  # Enable the Pantheon Desktop Environment.
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.windowManager.qtile.enable = true;
  services.xserver.desktopManager.pantheon.enable = true;
  # enable qtile
  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "intl";
  };

  # Configure console keymap
  console.keyMap = "us";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # enable NTFS
  boot.supportedFilesystems = [ "ntfs" ];

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  programs.steam.enable = true;
  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ivn = {
    isNormalUser = true;
    description = "ivn";
    extraGroups = [ "networkmanager" "wheel" "dialout" "libvirtd" ];
    packages = with pkgs; [
      obsidian
      bun
    ];
  };
  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    python312Packages.qtile
    util-linux
    cryptsetup
    screen
    #neovim
    arduino
    arduino-core
    arduino-cli
    claude-code
    arduino-language-server
    clang-tools
    #rocmPackages_5.llvm.clang-unwrapped
    mdcat
    blender
    nil
    virt-manager
    libvirt
    google-chrome
    go
    spotify
    wget
    thunderbird
    brave
    kitty
    git
    fd
    jq
    tree
    discord
    openvpn
    protonvpn-gui
    lsd
    bat
    picom
    rofi
    nodejs_24
    htop
    ripgrep
    xclip
    scrot
    zip
    unzip
    cargo
    luarocks
    alsa-utils
    brightnessctl
    usbutils
    traceroute
    docker-compose
    docker_27
    steam
    burp
    burpsuite
  ];

  #fonts.packages = with pkgs; [
  fonts.packages = [
    pkgs.nerd-fonts._0xproto
    pkgs.nerd-fonts.droid-sans-mono
    pkgs.nerd-fonts.iosevka
    pkgs.nerd-fonts.tinos
    pkgs.nerd-fonts.open-dyslexic

  ];
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ 12345 ];
  #networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  #system.stateVersion = "24.11"; # Did you read the comment?
  system.stateVersion = "25.05"; # Did you read the comment?
}
