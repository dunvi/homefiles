{ config, pkgs, ... }:

let
  userConf = {
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
in {
  users.groups.docker = {};

  users.users = {
    l = userConf;
    nixos = userConf;
  };
}

