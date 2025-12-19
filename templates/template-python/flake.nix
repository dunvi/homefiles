{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    devenv.url = "github:cachix/devenv";
  };

  outputs = inputs@{ flake-parts, nixpkgs, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.devenv.flakeModule
      ];
      systems = nixpkgs.lib.systems.flakeExposed;

      perSystem = { config, pkgs, ... }: {
        devenv.shells.default = {
          name = "template-python";

          packages = [
          ];

          languages.python = {
            enable = true;

            #version = 3.11.7

            venv = {
              enable = true;
              quiet = true;
              requirements = ''
                python-dateutil
                requests
              '';
            };
          };

          enterShell = ''
            python ./hello-world.py
          '';
        };
      };
    };
}

