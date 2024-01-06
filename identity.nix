{ config, pkgs, ... }:

{
  home.username = "l";
  home.homeDirectory = "/Users/l";

  programs.git = {
    userName = "dunvi";
    userEmail = "dunvi.dunvi@gmail.com";
  };
}
