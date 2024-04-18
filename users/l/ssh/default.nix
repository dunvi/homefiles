{ config, lib, pkgs, ... }:

let
  expectedKeys = [
    "github_ed25519"
    "github_moment_ed25519"
  ];

  keyargs = builtins.map (k: "$HOME/.ssh/" + k) expectedKeys;
in {
  home.file.".ssh/config" = {
    text = ''
      Host moment.github.com
      HostName github.com
      IdentityFile ~/.ssh/github_moment_ed25519
      IdentitiesOnly yes

      Host github.com
      HostName github.com
      IdentityFile ~/.ssh/github_ed25519
      IdentitiesOnly yes
    '';
    executable = false;
  };

  systemd.user.services.add-ssh-keys = {
    Unit = {
      Description = "Ensure SSK keys are added to the agent";
      After = [ "ssh-agent.service" ];
    };

    Install.WantedBy = [ "default.target" ];

    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.writeShellScript "add-ssh-keys" ''
        ${pkgs.systemd}/bin/systemctl --user import-environment XDG_RUNTIME_DIR
        export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent"
        ${pkgs.openssh}/bin/ssh-add -v ${builtins.toString keyargs}
      ''}";
    };
  };
}
