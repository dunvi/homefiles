# low-level configurations for martha
{ config, lib, pkgs, modulesPath, ... }:

{
  nix.settings = {
    trusted-users = [ "nixos" ];
  };

  imports = [
    <nixos-wsl/modules>
    ./networking.nix
  ];

  wsl = {
    enable = true;
    defaultUser = "nixos";
  };

  programs.nix-ld = {
    enable = true;
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
