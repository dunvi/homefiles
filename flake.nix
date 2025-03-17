{
  description = "flake setup baseline";

  inputs = {
    nix-unstable = {
      url = "github:nixos/nixpkgs/nixpkgs-unstable";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nix-unstable";
    };
  };

  outputs = inputs@{ self, nix-unstable, home-manager, ... }:
    let
      baseConf = import ./users/l;
      marthaMerges = import ./users/l/per/martha.nix;

      marthaSystem = "x86_64-linux";
      momentSystem = "aarch64-darwin";

      nixosModules = [
        ./configuration
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.l = nix-unstable.lib.mkMerge [
            marthaMerges
            baseConf
          ];
        }
      ];

      marthaConfig = nix-unstable.lib.nixosSystem {
        system = marthaSystem;
        modules = nixosModules;
      };

      momentConfig = home-manager.lib.homeManagerConfiguration {
          pkgs = import nix-unstable {
            system = momentSystem;
          };

          extraSpecialArgs = {
            #pkgs23_11 = import nix-23_11 {
            #  system = momentSystem;
            #};
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
