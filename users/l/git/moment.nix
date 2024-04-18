{ config, pkgs, lib, ... }:

let
  # TODO: can i hide the repo list and my user email in the
  #       private repository? I would be a lot happeier with that.

  # Add moment repositories to this list
  momentRepos = [
    "atlas"
    "moment"
  ];

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
  overrideConfigs = builtins.map overrideFn momentRepos;

  flakeLoc = "~/sources/flakes-moment";

  envrcFn = repo:
    {
      name = "sources/${repo}/.envrc";
      value = {
        text = "use flake ${flakeLoc}/${repo} --impure";
        executable = false;
      };
    };
  envrcs = builtins.listToAttrs (builtins.map envrcFn momentRepos);
in {

  # For all moment repositories, set identity to moment account
  programs.git.includes = overrideConfigs;

  # Copy in the .envrcs to all such repositories
  home.file = envrcs;
}
