{ config, pkgs, lib, ... }:

{
  home.username = lib.mkDefault "linnea";
  home.homeDirectory = lib.mkDefault "/Users/linnea";

  home.packages = with pkgs; [
    (writeShellScriptBin "nixre" ''
      home-manager switch --flake ~/sources/homefiles
    '')
  ];
}
