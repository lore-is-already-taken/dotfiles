{
    description = "testing Flake";
    inputs = {
        nixpkgs = {
            #url = "github:nixos/nixpkgs/nixos-unstable";
            url = "github:nixos/nixpkgs/nixos-25.05";
        };
        home-manager = {
            url = "github:nix-community/home-manager/release-25.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { nixpkgs, home-manager, ... }:
    let
        lib = nixpkgs.lib;
        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${system};
    in {
        nixosConfigurations ={
            nixos = lib.nixosSystem {
                inherit system;
                modules = [ 
                    ./configuration.nix
                    home-manager.nixosModules.home-manager
                    {
                        home-manager.useGlobalPkgs = true;
                        home-manager.useUserPackages = true;
                        home-manager.backupFileExtension = "backup";
                        home-manager.users.ivn = import ./home.nix;
                    }
                ];
            };
        };
    };
}
