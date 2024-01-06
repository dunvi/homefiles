{ config, pkgs, ... }:

{
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  home.packages = [
    pkgs.llvm

    pkgs.htop

    pkgs.cachix
    pkgs.direnv

    pkgs.colima
    pkgs.docker
    pkgs.docker-compose

    (pkgs.google-cloud-sdk.withExtraComponents [
        pkgs.google-cloud-sdk.components.gke-gcloud-auth-plugin
    ])

    (pkgs.writeShellScriptBin "cdls" ''
      cd $1
      ls
    '')
  ];

  imports = [
    ./identity.nix
    ./zsh/zsh.nix
    ./vim/vim.nix
    ./git.nix
  ];

  # putting here as long as we are not using the built-in alacritty support
  xdg.configFile."alacritty" = {
    source = ./alacritty;
    recursive = true;
  };

  programs.home-manager.enable = true;
}
