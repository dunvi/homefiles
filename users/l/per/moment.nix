{ config, pkgs, pkgs23_11, lib, ... }:

{
  home.username = lib.mkDefault "linnea";
  home.homeDirectory = lib.mkDefault "/Users/linnea";

  home.packages = [
    pkgs23_11.colima
    pkgs.docker
    pkgs.kubectl

    (pkgs.writeShellScriptBin "nixre" ''
      home-manager switch --flake ~/sources/homefiles --impure
    '')
  ];

  xdg.configFile."alacritty/per.toml" = {
    text = ''
      [font]
      size = 14
    '';
  };
}
