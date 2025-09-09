{ config, pkgs, ... }:

{
  services = {
    libinput.enable = true;
    displayManager.sddm.enable = true;

    # Enable the KDE Plasma Desktop Environment.
    desktopManager.plasma6.enable = true;

    libinput = {
      touchpad = {
        tapping = false;
        disableWhileTyping = true;
        naturalScrolling = false;
        horizontalScrolling = true;
      };
    };

    # Configure keymap in X11
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "";
        options = "ctrl:nocaps";
      };
    };
  };
  console.useXkbConfig = true;
}
