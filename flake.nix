{
  description = "flake setup baseline";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixpkgs-unstable";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    devenv = {
      url = "github:cachix/devenv/latest";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }:
    let
      nixosSystem = "x86_64-linux";

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
        system = nixosSystem;
        modules = nixosModules;
      };

      momentConfig = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "aarch64-darwin";
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
