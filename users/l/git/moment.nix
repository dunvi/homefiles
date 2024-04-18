{ config, pkgs, lib, ... }:

let
  # TODO: hide these in an import? autodetect moment repositories?
  # TODO: make this opt out instead of opt in?

  # Add moment repositories to this list
  momentRepos = [
    "atlas"
    #"moment"
  ];

  identityFn = repo:
    {
      condition = "gitdir:~/sources/${repo}/**";
      contents = {
        user.name = "linnea";
        user.email = "linnea@moment.dev";
      };
    };
  identities = builtins.map identityFn momentRepos;

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
  programs.git.includes = identities;

  # Copy in the .envrcs to all such repositories
  home.file = envrcs;
}
