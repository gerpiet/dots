{ lib, config, pkgs, ... }:
{
    services.syncthing = {
        enable = true;
        user = "pi";
        dataDir = "/home/pi/Documents";
        configDir = "/home/pi/Documents/.config/syncthing";
        overrideDevices = true;
        overrideFolders = true;
        settings = {
          devices."fairphone3".id = "QSTMZE3-LQDGPEQ-XTZQGEM-XNV7PZR-FPUEUNB-VQ4FEBQ-645KUQG-PAMIDQJ";
          folders = {
            "obsidian-personal-vault" = {
                path = "/home/pi/Documents/syncthing/obsidian-personal-vault";
                devices = [ "fairphone3" ];
            };
            "life-photos" = {
                path = "/home/pi/Documents/syncthing/life-photos";
                devices = [ "fairphone3" ];
            };
            "birday-normal-export-format" = {
                path = "/home/pi/Documents/syncthing/birday-normal-export-format";
                devices = [ "fairphone3" ];
            };
            "keepass" = {
              path = "/home/pi/Documents/syncthing/keepass";
              devices = [ "fairphone3" ];
            };
          };
        };
    };
} 