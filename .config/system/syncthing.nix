/**
  * Syncthing configuration
*/

{ ... }:

{
  systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true"; # Don't create default ~/Sync folder
  services.syncthing = {
    enable = true;
    user = "pi";
    dataDir = "/home/pi/Documents";
    configDir = "/home/pi/.config/syncthing";
    overrideFolders = true;
    overrideDevices = true;
    settings = {
      devices."FP3".id = "RIS5ISR-MNPWDSD-HDJCKKM-B6N5PHA-MFM3DF5-DHO7E2T-OMLUK65-4DME3AT";
      folders = {
        "obsidian-personal-vault" = {
          path = "/home/pi/Documents/syncthing/obsidian-personal-vault";
          devices = [ "FP3" ];
        };
        "life-photos" = {
          path = "/home/pi/Documents/syncthing/life-photos";
          devices = [ "FP3" ];
        };
        "app-backup" = {
          path = "/home/pi/Documents/syncthing/app-backup";
          devices = [ "FP3" ];
        };
        "keepass" = {
          path = "/home/pi/Documents/syncthing/keepass";
          devices = [ "FP3" ];
        };
      };
    };
  };
}
