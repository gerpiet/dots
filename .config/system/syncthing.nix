/**
  * Syncthing configuration
*/

{ ... }:

{
  systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true"; # Don't create default ~/Sync folder
  services.syncthing = {
    enable = true;
    user = "pi";
    dataDir = "home/pi/Documents/syncthing";
    configDir = "/home/pi/.config/syncthing";
    overrideFolders = true;
    overrideDevices = true;
    settings = {
      devices."FP3".id = "RIS5ISR-MNPWDSD-HDJCKKM-B6N5PHA-MFM3DF5-DHO7E2T-OMLUK65-4DME3AT";
      folders = {
        "app-backup" = {
          path = "~/Documents/syncthing/app-backup";
          devices = [ "FP3" ];
        };
        "keepass" = {
          path = "~/Documents/syncthing/keepass";
          devices = [ "FP3" ];
        };
        "life-photos" = {
          path = "~/Documents/syncthing/life-photos";
          devices = [ "FP3" ];
        };
        "obsidian-personal-vault" = {
          path = "~/Documents/syncthing/obsidian-personal-vault";
          devices = [ "FP3" ];
        };
        "organize" = {
          path = "~/Documents/syncthing/organize";
          devices = [ "FP3" ];
        };
      };
    };
  };
}
