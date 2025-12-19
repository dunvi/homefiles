{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{ nixpkgs, flake-parts, ... }:
    let
      javaVersion = 17;

      overlays = [
        (final: prev: rec {
          jdk = prev."jdk${toString javaVersion}";
          gradle = prev.gradle.override { java = jdk; };
          kotlin = prev.kotlin.override { jre = jdk; };
        })
      ];
    in flake-parts.lib.mkFlake { inherit inputs; } {
      systems = nixpkgs.lib.systems.flakeExposed;

      perSystem = { config, system, pkgs, ... }:
      let
      in {
        devShells.default = pkgs.mkShell {
          name = "template-kotlin";

          buildInputs = [
            pkgs.kotlin
            #pkgs.gradle
            #gcc
            #ncurses
            #patchelf
            #zlib

            (pkgs.writeShellScriptBin "hello-world" ''
              if [[ -f ./gradlew ]] ; then
                ./gradlew run
              else
                kotlinc -script hello-world.kts
              fi
            '')
          ];

          shellHook = ''
            hello-world
          '';
        };
      };
    };
}

