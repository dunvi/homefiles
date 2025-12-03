{ config, pkgs, ... }:

let
  identities = import ./identity.nix;
in {
  programs.home-manager.enable = true;

  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    llvm

    ghostty
    htop

    (writeShellScriptBin "cdls" ''
      cd $1
      ls
    '')
  ];

  imports = [
    ./ssh
    ./git
    ./zsh
    ./vim
  ];

  # map users in the identity file to uses.
  l.user = identities.gitUsers.default;

  # putting here as long as we are not meaningfully using the built-in alacritty support
  programs.alacritty.enable = true;
  xdg.configFile."alacritty" = {
    source = ./alacritty;
    recursive = true;
  };

  xdg.configFile."ghostty" = {
    source = ./ghostty;
    recursive = true;
  };

  programs.direnv.enable = true;
}
