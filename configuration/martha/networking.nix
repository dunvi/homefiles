{ config, lib, ... }:

{
  networking = {
    hostName = "martha";

    useDHCP = lib.mkDefault true;
    # interfaces.wlp0s20f3.useDHCP = lib.mkDefault true;

    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    networkmanager.enable = true;
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable ssh by default.
  programs.ssh.startAgent = true;

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
}
