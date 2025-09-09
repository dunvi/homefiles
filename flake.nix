{
  description = "flake setup baseline";

  inputs = {
    nix-unstable = {
      url = "github:nixos/nixpkgs/nixpkgs-unstable";
    };

    nixos-hardware = {
      url = "github:nixos/nixos-hardware/master";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nix-unstable";
    };
  };

  outputs = inputs@{ self, nix-unstable, nixos-hardware, home-manager, ... }:
    let
      baseConf = import ./users/l;
      marthaMerges = import ./users/l/per/martha.nix;

      marthaSystem = "x86_64-linux";
      #momentSystem = "aarch64-darwin";

      nixosModules = [
        nixos-hardware.nixosModules.dell-xps-15-9530
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

      # retained for memory of how to link up MacOS config
      # delete if consumed for a new configuration
      #momentConfig = home-manager.lib.homeManagerConfiguration {
      #  pkgs = import nix-unstable {
      #    system = momentSystem;
      #  };
      #  modules = [
      #    ./users/l/per/moment.nix
      #    ./users/l
      #  ];
      #};

    in {
      systemPackages = nix-unstable;

      nixosConfigurations = {
        martha = marthaConfig;
        nixos = marthaConfig; # Useful to keep around if reinstalling
      };

      homeConfigurations = {
        #"linnea" = momentConfig;
      };
    };
}
