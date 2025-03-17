{ config, pkgs, lib, ... }:

{
  home.username = lib.mkDefault "l";
  home.homeDirectory = lib.mkDefault "/home/l";

  imports = [
    /home/l/sources/flakes-moment/moment.nix
  ];

  home.packages = with pkgs; [
    firefox

    zoom-us
    slack

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
      size = 11
    '';
  };
}
