let
  #nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-unstable";
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-25.05";
  pkgs = import nixpkgs { config = {}; };
in
pkgs.mkShell {
  # Set NIX_LD_LIBRARY_PATH and NIX_LD for Python binary compatibility
  shellHook = ''
    export NIX_LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath [ pkgs.stdenv.cc.cc pkgs.zlib ]}
    export LD_LIBRARY_PATH=$NIX_LD_LIBRARY_PATH
    export NIX_LD=$(cat ${pkgs.stdenv.cc}/nix-support/dynamic-linker)
  '';
  
  packages = with pkgs; [
    gnumake
    lua-language-server
    stylua
    nixpkgs-fmt
    lemminx
  ];
}

