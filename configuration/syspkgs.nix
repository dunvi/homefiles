{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    #git
    #vim
    #wget
  ];

  programs.zsh.enable = true;

  /*
  # https://nixos.wiki/wiki/Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
  */

  services.printing.enable = true;

  programs.adb.enable = true;

  virtualisation.docker.enable = true;
}
