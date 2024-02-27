{ config, pkgs, ... }:

{
  users.users.l = {
    isNormalUser = true;
    description = "l";
    extraGroups = [
      "adbusers"
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
  };
}

