{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;

    profileExtra = ''
      setopt nobeep
      setopt promptsubst
      setopt inc_append_history

      setopt COMPLETE_IN_WORD
      setopt chaselinks
      setopt noclobber
      setopt notify

      unsetopt correct
      unsetopt nomatch
      setopt extendedglob

      setopt RM_STAR_WAIT
    '';

    history = {
      extended = true;
      share = false;
      ignoreAllDups = true;
      ignoreSpace = true;
      ignorePatterns = [
        "ls *"
        "cd *"
        "cd.."
        "[bf]g"
        "exit"
        "reset"
        "clear"
      ];
    };

    shellAliases = {
      ls = "ls -alFG";
      "cd.." = "cd ..";

      grep = "grep --color=auto";

      # move this to a ruby specific module
      #rspec = "bundle exec rspec --format documentation";
    };

    # this file still holds colors, prompt magic, and some bindkeys.
    # i think these can get moved out as well, but i need more smarts.
    initExtra = builtins.readFile ./zshrc;
  };
}
