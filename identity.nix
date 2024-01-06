{ config, pkgs, lib, ... }:

{
  home.username = lib.mkDefault "l";
  home.homeDirectory = lib.mkDefault "/Users/l";

  programs.git = {
    userName = lib.mkDefault "dunvi";
    userEmail = lib.mkDefault "dunvi.dunvi@gmail.com";
  };
}
