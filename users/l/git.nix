{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    package = pkgs.git;

    aliases = {
      head = "log -n 1";
      graph = "log --graph --oneline --decorate --all";
    };

    ignores = [
      "*.swp"

      ".direnv"
      "devenv.local.nix"
      ".devenv"
      #".envrc"
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
      url = {
        "git@github.com:".insteadOf = [ 
          "https://github.com/" 
          "https://github.com" 
        ];
        "git@gitlab.com:".insteadOf = [ 
          "https://gitlab.com/" 
          "https://gitlab.com"
        ];
      };
    };
  };
}

