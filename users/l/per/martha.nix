{ config, pkgs, lib, ... }:

{
  home.username = lib.mkDefault "l";
  home.homeDirectory = lib.mkDefault "/home/l";

  imports = [];

  home.packages = with pkgs; [
    firefox

    signal-desktop
    discord

    (writeShellScriptBin "sysre" ''
      systemctl reboot
    '')

    (writeShellScriptBin "nixre" ''
      sudo nixos-rebuild switch --impure
    '')

    (writeShellScriptBin "nixcl" ''
      sudo nix-collect-garbage --delete-older-than 5d
    '')
  ];

  xdg.configFile."alacritty/per.toml" = {
    text = ''
      [font]
      size = 15
    '';
  };
}
