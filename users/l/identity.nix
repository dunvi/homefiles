{ config, pkgs, lib, ... }:

{
  home.username = lib.mkDefault "linnea";
  home.homeDirectory = lib.mkDefault "/Users/linnea";

  # default git identity for this computer
  programs.git = {
    userName = lib.mkDefault "dunvi";
    userEmail = lib.mkDefault "dunvi.dunvi@gmail.com";
  };
}
