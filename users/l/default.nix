{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;

  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    llvm

    htop

    #cachix
    #direnv
    #devenv

    #colima
    #docker
    #docker-compose

    firefox

    discord
    zoom-us
    signal-desktop

    (writeShellScriptBin "cdls" ''
      cd $1
      ls
    '')

    (writeShellScriptBin "sysre" ''
      systemctl reboot
    '')

    (writeShellScriptBin "nixre" ''
      sudo nixos-rebuild switch --impure
    '')
  ];

  imports = [
    ./identity.nix
    ./ssh
    ./git
    ./zsh
    ./vim
  ];

  # putting here as long as we are not meaningfully using the built-in alacritty support
  programs.alacritty.enable = true;
  xdg.configFile."alacritty" = {
    source = ./alacritty;
    recursive = true;
  };

  programs.direnv.enable = true;
}
