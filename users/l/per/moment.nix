# This file is retained for educational purposes
# (aka, copy paste in the future). If it is consumed
# in such a way, go ahead and delete this file.

{ config, pkgs, lib, ... }:

{
  home.username = lib.mkDefault "linnea";
  home.homeDirectory = lib.mkDefault "/Users/linnea";

  imports = [
    /Users/linnea/sources/flakes-moment/moment.nix
  ];

  home.packages = [
    pkgs.colima
    pkgs.docker
    pkgs.kubectl

    (pkgs.writeShellScriptBin "nixre" ''
      home-manager switch --flake ~/sources/homefiles --impure
    '')
  ];

  home.sessionVariables = {
    DOCKER_HOST = "unix:///Users/linnea/.colima/default/docker.sock";
  };

  xdg.configFile."alacritty/per.toml" = {
    text = ''
      [[keyboard.bindings]]
      key = "N"
      mods = "Command"
      action = "SpawnNewInstance"

      [[keyboard.bindings]]
      key = "N"
      mods = "Command|Shift"
      action = "CreateNewWindow"

      [font]
      size = 14
    '';
  };

  programs.zsh.initExtra = ''
    bindkey '^[[1;9C' emacs-forward-word
    bindkey '^[[1;9D' emacs-backward-word
  '';
}
