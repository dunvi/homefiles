{ config, pkgs, ... }:

{
  services.libinput.enable = true;
  services.displayManager.sddm.enable = true;

  # Configure keymap in X11
  services.xserver = {
    enable = true;

    # Enable the KDE Plasma Desktop Environment.
    desktopManager.plasma5.enable = true;

    xkb = {
      layout = "us";
      variant = "";
      options = "ctrl:nocaps";
    };

    libinput = {
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
