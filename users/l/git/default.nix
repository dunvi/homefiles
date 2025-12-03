{ config, pkgs, lib, ... }:



let
  cfg = config.l;
in {
  options.l.user = lib.mkOption {
    type = lib.types.submodule({ config, ... }: {
      options = {
        name = lib.mkOption {
          type = lib.types.str;
        };
        email = lib.mkOption {
          type = lib.types.str;
        };
      };
    });
  };

  config = {
    programs.git = {
      enable = true;
      package = pkgs.git;

      ignores = [
        "nocommit/"
        "*.swp"

        ".direnv"
        "devenv.local.nix"
        ".devenv"
        ".envrc"
        ".pre-commit-config.yaml"

        "out/"
        ".bloop/"
        ".gradle/"
        ".idea/"
        "setup/.idea/"
        "*/*.iml"

        "**/scalatra-local.conf"
      ];

      settings = {
        alias = {
          head = "log -n 1";
          graph = "log --graph --oneline --decorate --all";
        };

        user = {
          name = cfg.user.name;
          email = cfg.user.email;
        };

        branch.sort = "-committerdate";
        core.hooksPath = "/dev/null";
        diff.algorithm = "histogram";
        diff.renames = true;
        init.defaultBranch = "main";
        pager.branch = false;
        push.default = "nothing";
        tag.sort = "version:refname";

        advice = {
          ambiguousFetchRefspec = false;
          fetchShowForcedUpdates = false;
          pushUpdateRejected = false;
          pushNonFFCurrent = false;
          pushNonFFMatching = false;
          pushAlreadyExists = false;
          pushFetchFirst = false;
          pushNeedsForce = false;
          pushUnqualifiedRefname = false;
          pushRefNeedsUpdate = false;
          skippedCherryPicks = false;
          statusAheadBehind = false;
          statusHints = false;
          statusUoption = false;
          commitBeforeMerge = false;
          resetNoRefresh = false;
          resolveConflict = false; 
          sequencerInUse = false;
          implicitIdentity = false;
          detachedHead = false;
          suggestDetachingHead = false;
          checkoutAmbiguousRemoteBranchName = false;
          amWorkDir = false;
          rmHints = false;
          addEmbeddedRepo = false;
          ignoredHook = false;
          waitingForEditor = false;
          nestedTag = false;
          submoduleAlternateErrorStrategyDie = false;
          submodulesNotUpdated = false;
          addIgnoredFile = false;
          addEmptyPathspec = false;
          updateSparsePath = false;
          diverging = false;
          worktreeAddOrphan = false;
        };
      };
    };

    home.packages = let
      init-proj-sc = builtins.readFile ./init-project.sh;
    in [
      (pkgs.writeScriptBin "init-project" init-proj-sc)
    ];
  };
}

