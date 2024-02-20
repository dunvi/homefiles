{ ... }:

{
  boot.initrd = {
    availableKernelModules = [
      "xhci_pci"
      "thunderbolt"
      "vmd"
      "nvme"
      "usb_storage"
      "sd_mod"
      "rtsx_pci_sdmmc"
    ];
    kernelModules = [ ];
  };

  boot = {
    kernelModules = [
      "kvm-intel"
    ];

    extraModulePackages = [ ];
  };
}
