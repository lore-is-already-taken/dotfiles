{
    description = "testing Flake";
    inputs = {
        nixpkgs = {
            #url = "github:nixos/nixpkgs/nixos-unstable";
            url = "github:nixos/nixpkgs/nixos-24.05";
        };
        #nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    };

    outputs = { self, nixpkgs, ... }:
    let
        lib = nixpkgs.lib;
    in {
        nixosConfigurations ={
            nixos = lib.nixosSystem {
                system = "x86_64-linux";
                modules = [ ./configuration.nix ./virtualbox.nix ];
            };
        };
    };
}
