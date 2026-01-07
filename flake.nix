{
  description = "flake setup baseline";

  inputs = {
    nix-unstable = {
      url = "github:nixos/nixpkgs/nixpkgs-unstable";
    };

    nixos-hardware = {
      url = "github:nixos/nixos-hardware/master";
    };

    lix = {
      url = "https://git.lix.systems/lix-project/lix/archive/main.tar.gz";
      flake = false;
    };

    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/main.tar.gz";
      inputs.nixpkgs.follows = "nix-unstable";
      inputs.lix.follows = "lix";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nix-unstable";
    };
  };

  outputs = inputs@{ self, lix, lix-module, nix-unstable, nixos-hardware, home-manager, ... }:
    let
      baseUserConf = import ./users/l;
      marthaUserMerges = [(import ./users/l/per/martha.nix)];
      oliviaUserMerges = [(import ./users/l/per/olivia.nix)];

      marthaSystem = "x86_64-linux";
      oliviaSystem = "x86_64-linux";
      #momentSystem = "aarch64-darwin";

      nixosModules = (userMerges: let
        userConfs = nix-unstable.lib.mkMerge ([
          baseUserConf
        ] ++ userMerges);
      in [
        lix-module.nixosModules.default
        ./configuration
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.l = userConfs;
          home-manager.users.nixos = userConfs;
        }
      ]);

      marthaConfig = nix-unstable.lib.nixosSystem {
        system = marthaSystem;
        modules = nixosModules(marthaUserMerges) ++ [
          ./configuration/martha
          nixos-hardware.nixosModules.dell-xps-15-9530
        ];
      };

      oliviaConfig = nix-unstable.lib.nixosSystem {
        system = oliviaSystem;
        modules = nixosModules(oliviaUserMerges) ++ [
          ./configuration/olivia
        ];
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
      nixosConfigurations = {
        martha = marthaConfig;
        olivia = oliviaConfig;
        nixos = oliviaConfig; # Use when reinstalling
      };

      homeConfigurations = {
        #"linnea" = momentConfig;
      };
    };
}
