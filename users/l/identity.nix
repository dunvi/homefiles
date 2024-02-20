{ config, pkgs, lib, ... }:

{
  # TODO: find a way to define these are vars, while setting
  # the actual attributes in their appropriate configuration files

  home.username = lib.mkDefault "l";
  home.homeDirectory = lib.mkDefault "/home/l";

  programs.git = {
    userName = lib.mkDefault "dunvi";
    userEmail = lib.mkDefault "dunvi.dunvi@gmail.com";
  };
}
