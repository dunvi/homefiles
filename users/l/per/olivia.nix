{ config, pkgs, lib, ... }:

{
  home.username = lib.mkDefault "nixos";
  home.homeDirectory = lib.mkDefault "/home/nixos";

  imports = [];

  home.packages = with pkgs; [
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
