{ config, pkgs, ... }:

{
  # Configure keymap in X11
  services.xserver = {
    enable = true;

    # Enable the KDE Plasma Desktop Environment.
    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;

    xkb = {
      layout = "us";
      variant = "";
      options = "ctrl:nocaps";
    };

    libinput = {
      enable = true;

      touchpad = {
        tapping = false;
        disableWhileTyping = true;
        naturalScrolling = false;
        horizontalScrolling = true;
      };
    };
  };
  console.useXkbConfig = true;
}
