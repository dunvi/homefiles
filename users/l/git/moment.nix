{ config, pkgs, lib, ... }:

let
  # TODO: can i hide the repo list and my user email in the
  #       private repository? I would be a lot happeier with that.

  momentRepos = {
    "none" = [ "flakes-moment" ];

    # Add moment repositories to this list
    "atlas" = [ "atlas" "atlas-mom" ];
    "moment" = [ "moment" ];
  };

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
  allGitRepos = lib.lists.flatten (lib.attrsets.mapAttrsToList (_: repos: repos) momentRepos);
  overrideConfigs = builtins.map overrideFn allGitRepos;

  flakeLoc = "${config.home.homeDirectory}/sources/flakes-moment";
  envrcFn = flake: repo:
    {
      name = "sources/${repo}/.envrc";
      value = {
        text = "use flake path:${flakeLoc}/${flake} --impure";
        executable = false;
      };
    };

  unfolder = flake: repos:
    builtins.map (repo: envrcFn flake repo) repos;

  flakesOnly = builtins.removeAttrs momentRepos [ "none" ];
  flakified = lib.lists.flatten (lib.attrsets.mapAttrsToList unfolder flakesOnly);
  envrcs = builtins.listToAttrs flakified;
in {

  # For all moment repositories, set identity to moment account
  programs.git.includes = overrideConfigs;

  # Copy in the .envrcs to all such repositories
  home.file = envrcs;
}
