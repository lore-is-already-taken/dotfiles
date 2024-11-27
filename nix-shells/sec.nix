let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-unstable";
  pkgs = import nixpkgs { config = {}; overlays = []; };
in

pkgs.mkShellNoCC {
  packages = with pkgs; [
john
wfuzz
metasploit
gobuster
nmap
aircrack-ng
sqlmap
exploitdb
hashcat
hcxtools
ffuf
netcat-gnu
  ];
}
