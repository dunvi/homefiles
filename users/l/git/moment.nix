{ config, pkgs, lib, ... }:

let
  # TODO: can i hide the repo list and my user email in the
  #       private repository? I would be a lot happeier with that.

  # Add moment repositories to this list
  momentFlakes = builtins.filter (repo: builtins.pathExists ~/sources/${repo}) [
    "atlas"
    "moment"

    # excluded because this repository is not itself a nix flake
    #"flakes-moment"
  ];

  momentAll = momentFlakes ++ [ "flakes-moment" ];

  overrideFn = repo:
    {
      condition = "gitdir:~/sources/${repo}/**";
      contents = {
        user = {
          name = "linnea";
          email = "linnea@moment.dev";
        };

        url = {
          "git@moment.github.com".insteadOf = [
            "git@github.com"
          ];
          "git@moment.github.com:".insteadOf = [
            "https://github.com/"
            "https://github.com"
            "https://moment.github.com/"
            "https://moment.github.com"
          ];
          "git@gitlab.com:".insteadOf = [
            "https://gitlab.com/"
            "https://gitlab.com"
          ];
        };
      };
    };
  overrideConfigs = builtins.map overrideFn momentAll;

  flakeLoc = "${config.home.homeDirectory}/sources/flakes-moment";

  envrcFn = repo:
    {
      name = "sources/${repo}/.envrc";
      value = {
        text = "use flake path:${flakeLoc}/${repo} --impure";
        executable = false;
      };
    };
  envrcs = builtins.listToAttrs (builtins.map envrcFn momentFlakes);
in {

  # For all moment repositories, set identity to moment account
  programs.git.includes = overrideConfigs;

  # Copy in the .envrcs to all such repositories
  home.file = envrcs;
}
