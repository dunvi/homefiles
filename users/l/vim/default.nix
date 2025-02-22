{ config, pkgs, ... }:

{
  programs.vim = {
    enable = true;
    defaultEditor = true;
    packageConfigurable = pkgs.vim-full;

    plugins = [
      pkgs.vimPlugins.ale
      pkgs.vimPlugins.rust-vim
      pkgs.vimPlugins.vim-go
      pkgs.vimPlugins.yats-vim
    ];

    # most of the vim config cannot be moved into this block in its current state
    # so we continue to maintain all config in vimrc for consistency.
    extraConfig = builtins.readFile ./vimrc;
  };

  home.file.".vim/colors" = {
    source = ./colors;
    recursive = true;
  };
}
