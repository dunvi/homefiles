{
  description = "flake setup baseline";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixpkgs-unstable";
    };

    nix23_11 = {
      url = "github:nixos/nixpkgs/nixos-23.11";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    devenv = {
      url = "github:cachix/devenv/latest";
    };
  };

  outputs = inputs@{ self, nixpkgs, nix23_11, home-manager, ... }:
    let
      baseConf = import ./users/l;
      marthaMerges = import ./users/l/per/martha.nix;

      nixosModules = [
        ./configuration
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.l = nixpkgs.lib.mkMerge [marthaMerges baseConf];
        }
      ];

      marthaConfig = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = nixosModules;
      };

      momentConfig = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "aarch64-darwin";
          };

          extraSpecialArgs = {
            pkgs23_11 = import nix23_11 {
              system = "aarch64-darwin";
            };
          };

          modules = [
            ./users/l/per/moment.nix
            ./users/l
          ];
        };

    in {
      nixosConfigurations = {
        martha = marthaConfig;
        nixos = marthaConfig; # Useful to keep around if reinstalling
      };

      homeConfigurations = {
        "linnea" = momentConfig;
      };
    };
}
