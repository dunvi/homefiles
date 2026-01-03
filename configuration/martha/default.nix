# low-level configurations for martha
{ config, lib, pkgs, modulesPath, ... }:

{
  nix.settings = {
    trusted-users = [ "root" "l" ];
  };

  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ./kernel.nix
    ./disks.nix
    ./cpu.nix
    ./gpu.nix
    ./networking.nix
    ./xserver.nix
    #./sound.nix
  ];

  programs.nix-ld = {
    enable = true;
  };

  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 20;
    };
    efi.canTouchEfiVariables = true;
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
