/**
  * All things virtualisation
*/

{ ... }:

{
  # following configuration is added only when building VM with build-vm
  virtualisation.vmVariant = {
    virtualisation = {
      memorySize = 8192; # MB
      cores = 4;
    };
  };

  # Rootless docker
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };
}
