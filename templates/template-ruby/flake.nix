{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs-ruby.url = "github:bobvanderlinden/nixpkgs-ruby";
    nixpkgs-ruby.inputs.nixpkgs.follows = "nixpkgs";
    devenv.url = "github:cachix/devenv";
  };

  outputs = inputs@{ flake-parts, nixpkgs, nixpkgs-ruby, ... }:
  flake-parts.lib.mkFlake { inherit inputs; } {
    imports = [
      inputs.devenv.flakeModule
    ];
    systems = nixpkgs.lib.systems.flakeExposed;

    perSystem = { config, system, pkgs, ... }:
    let
      rbversion = "ruby-3.1";

      pkgs = nixpkgs.legacyPackages.${system};
      ruby = nixpkgs-ruby.packages.${system}.${rbversion};

      gems = pkgs.bundlerEnv {
        name = "gemset";
        inherit ruby;
        gemfile = ./Gemfile;
        lockfile = ./Gemfile.lock;
        gemset = ./gemset.nix;
        groups = [ "default" "production" "development" "test" ];
      };
    in
    {
      name = "template-ruby";

      devenv.shells.default = {
        packages = with pkgs; [
          # gems
          ruby
          bundix
        ];

        enterShell = ''
          ruby ./hello-world.rb
        '';
      };
    };
  };
}
