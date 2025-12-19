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

      perSystem = { pkgs, ... }: {
        devenv.shells.default = {
          name = "template-go";

          packages = [
            #pkgs.go_1_22
          ];

          languages.go = {
            enable = true;
          };

          enterShell = ''
            go run hello-world.go
          '';
        };
      };
    };
}
