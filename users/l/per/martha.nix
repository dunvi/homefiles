{ config, pkgs, lib, ... }:

{
  home.username = lib.mkDefault "l";
  home.homeDirectory = lib.mkDefault "/home/l";

  imports = [];

  home.packages = with pkgs; [
    firefox

    zoom-us

    (writeShellScriptBin "sysre" ''
      systemctl reboot
    '')

    (writeShellScriptBin "nixre" ''
      sudo nixos-rebuild switch --impure
    '')
  ];

  xdg.configFile."alacritty/per.toml" = {
    text = ''
      [font]
      size = 15
    '';
  };
}
