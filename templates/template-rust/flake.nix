{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";

    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ fenix, nixpkgs, flake-parts, ... }:
  let
  in
  flake-parts.lib.mkFlake { inherit inputs; } {
      systems = nixpkgs.lib.systems.flakeExposed;

      perSystem = { config, system, pkgs, ... }:
      let
        rustToolchain = fenix.packages.${system}.minimal.toolchain;
      in {
        devShells.default = pkgs.mkShell {
          name = "template-rust";

          buildInputs = [
            rustToolchain
          ];

          shellHook = ''
            rustc hello.rs
            ./hello
          '';
      };
    };
  };

}

