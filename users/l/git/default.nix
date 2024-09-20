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

      userName = cfg.user.name;
      userEmail = cfg.user.email;

      aliases = {
        head = "log -n 1";
        graph = "log --graph --oneline --decorate --all";
      };

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

        extraConfig = {
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
          core.hooksPath = "/dev/null";
          init.defaultBranch = "main";
          pager.branch = false;
          push.default = "nothing";
        };
      };

      home.packages = let
        init-proj-sc = builtins.readFile ./init-project.sh;
      in [
        (pkgs.writeScriptBin "init-project" init-proj-sc)
      ];
    };
  }

