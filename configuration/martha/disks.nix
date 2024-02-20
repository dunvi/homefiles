{ ... }:

{
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/90a66e44-7cb8-4edc-baba-8b5237d42ebb";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/4084-0ABF";
      fsType = "vfat";
    };
  };

  swapDevices = [
    {
      device = "/dev/disk/by-uuid/1e4991c6-bfb6-45a7-97a9-ac86848cb286";
    }
  ];
}
