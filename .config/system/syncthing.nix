/**
  * Syncthing configuration
*/

{ ... }:

{
  systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true"; # Don't create default ~/Sync folder
  services.syncthing = {
    enable = true;
    user = "pi";
    dataDir = "/home/pi/Documents/syncthing";
    configDir = "/home/pi/.config/syncthing";
    overrideFolders = true;
    overrideDevices = true;
    settings = {
      devices."FP3".id = "M7JF5LV-WWWNYVX-67MJ7KR-P4UPZPN-M2O55F5-OVMF5K7-YKMDGUT-2DZ5NQO";
      folders = {
        "school" = {
          path = "~/Documents/school";
          devices = [ "FP3" ];
        };
        "app-backup" = {
          path = "~/Documents/syncthing/app-backup";
          devices = [ "FP3" ];
        };
        "keepass" = {
          path = "~/Documents/syncthing/keepass";
          devices = [ "FP3" ];
        };
        "cookbook" = {
          "path" = "~/Documents/syncthing/obsidian/cookbook";
          devices = [ "FP3" ];
        };
        "main" = {
          path = "~/Documents/syncthing/obsidian/main";
          devices = [ "FP3" ];
        };
        "personal" = {
          path = "~/Documents/syncthing/obsidian/personal";
          devices = [ "FP3" ];
        };
      };
    };
  };
}
