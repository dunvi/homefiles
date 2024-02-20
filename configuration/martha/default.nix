# low-level configurations for martha
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ./kernel.nix
    ./disks.nix
    ./cpu.nix
    ./gpu.nix
    ./networking.nix
    ./sound.nix
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
