{
  description = "flake setup baseline";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }:
    let
      basecfg = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.l = import ./home.nix;
          }
        ];
      };
    in {
      nixosConfigurations = {
        martha = basecfg;
        nixos = basecfg; # Useful to keep around if reinstalling
      };

      # For standalone installation
      #homeConfigurations = {
      #  "l" = home-manager.lib.homeManagerConfiguration {
      #    pkgs = import nixpkgs {
      #      system = "x86_64-linux";
      #    };
      #
      #    modules = [
      #      ./home.nix
      #    ];
      #  };
      #};
    };
}
