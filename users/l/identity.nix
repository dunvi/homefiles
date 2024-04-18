{ config, pkgs, lib, ... }:

{
  home.username = lib.mkDefault "l";
  home.homeDirectory = lib.mkDefault "/home/l";

  # default git identity for this computer
  programs.git = {
    userName = lib.mkDefault "dunvi";
    userEmail = lib.mkDefault "dunvi.dunvi@gmail.com";
  };
}
