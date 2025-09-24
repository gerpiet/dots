/**
  * All things virtualisation
*/

{ ... }:

{
  # Following configuration is added only when building VM with build-vm
  virtualisation = {
    vmVariant = {
      virtualisation = {
        memorySize = 8192; # MB
        cores = 4;
      };
    };
    podman = {
      enable = true;
      dockerCompat = true;
    };
  };
}
