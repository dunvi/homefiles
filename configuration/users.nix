{ config, pkgs, ... }:

{
  users.users.l = {
    isNormalUser = true;
    description = "l";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };
}

