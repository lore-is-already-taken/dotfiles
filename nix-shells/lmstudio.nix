let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-unstable";
  #nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-24.11";
  pkgs = import nixpkgs { config = {
        allowUnfree = true;
        }; };
in
pkgs.mkShell {
  
  packages = with pkgs; [
            lmstudio
  ];
}

