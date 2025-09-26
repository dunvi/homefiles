{ config, pkgs, ... }:

{
  users.groups.docker = {};

  users.users.l = {
    isNormalUser = true;
    description = "l";
    extraGroups = [
      "adbusers"
      "docker"
      "kvm"
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
  };
}

