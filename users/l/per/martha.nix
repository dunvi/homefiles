{ config, pkgs, lib, ... }:

{
  home.username = lib.mkDefault "l";
  home.homeDirectory = lib.mkDefault "/home/l";

  home.packages = with pkgs; [
    firefox

    discord
    zoom-us
    signal-desktop
    slack

    (writeShellScriptBin "sysre" ''
      systemctl reboot
    '')

    (writeShellScriptBin "nixre" ''
      sudo nixos-rebuild switch --impure
    '')
  ];

  xdg.configFile."alacritty"."per.toml" = {
    text = ''
      [font]
      size = 11
    '';
  };
}
