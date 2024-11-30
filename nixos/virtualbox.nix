{ config, pkgs, lib, ... }:

{
  # Enable VirtualBox kernel modules
  virtualisation.virtualbox.host.enable = true;

  # Optional: Install VirtualBox guest additions (useful if running NixOS as a guest)
  virtualisation.virtualbox.guest.enable = false;

  # Optional: Add VirtualBox-related tools to the system packages
  environment.systemPackages = with pkgs; [
    virtualbox
    virtualbox-guest-additions
    virtualbox-extension-pack
  ];

  # Ensure the user is added to the vboxusers group
  users.users.ivn = {
    extraGroups = [ "vboxusers" ];
  };

  # Load VirtualBox kernel modules at boot
  boot.kernelModules = [
    "vboxdrv"
    "vboxnetflt"
    "vboxnetadp"
    "vboxpci"
  ];

  # (Optional) Set specific VirtualBox settings
  virtualisation.virtualbox.host.vboxmanage.enable = true;
}
