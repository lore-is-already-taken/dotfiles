{
    description = "testing Flake";
    inputs = {
        nixpkgs = {
            #url = "github:nixos/nixpkgs/nixos-unstable";
            url = "github:nixos/nixpkgs/nixos-24.11";
        };
    };

    outputs = { nixpkgs, ... }:
    let
        lib = nixpkgs.lib;
    in {
        nixosConfigurations ={
            nixos = lib.nixosSystem {
                system = "x86_64-linux";
                modules = [ ./configuration.nix  ];
            };
        };
    };
}
