{ config, pkgs, pkgs23_11, lib, ... }:

{
  home.username = lib.mkDefault "linnea";
  home.homeDirectory = lib.mkDefault "/Users/linnea";

  home.packages = [
    pkgs23_11.colima
    pkgs.docker
    pkgs.kubectl

    (pkgs.writeShellScriptBin "nixre" ''
      home-manager switch --flake ~/sources/homefiles --impure
    '')
  ];

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
