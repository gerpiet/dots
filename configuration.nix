# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  my-python-packages = ps: with ps; [
    pip
    pytest
    requests
    dnspython
    pygame
  ];
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];


  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 50;
  boot.loader.efi.canTouchEfiVariables = true;

  # Automatically upgrade and garbage collect.
  system.autoUpgrade = {
    enable = true;
    operation = "boot";
    dates = "15:00";
  };

  nix.gc = {
    automatic = true;
    dates = "Mon 14:00";
    options = "--delete-older-than 30d";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config = {
    # Allow unfree packages
    allowUnfree = true;
    # Patch for wpa_supplicant to make school WiFi work
    packageOverrides = pkgs: rec {
      wpa_supplicant = pkgs.wpa_supplicant.overrideAttrs (attrs: {
        patches = attrs.patches ++ [ ./patches/wpa_supplicant/legacy-wifi.patch ];
      });
    };
    # Temporary until obsidian etc. is fixed
    permittedInsecurePackages = [
      "electron-25.9.0"
    ];
  };

  

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-fc61ff11-73b2-4adc-9e7a-b5cc2ff906f4".device = "/dev/disk/by-uuid/fc61ff11-73b2-4adc-9e7a-b5cc2ff906f4";
  boot.initrd.luks.devices."luks-fc61ff11-73b2-4adc-9e7a-b5cc2ff906f4".keyFile = "/crypto_keyfile.bin";

  # NTFS support
  boot.supportedFilesystems = [ "ntfs" ];

  hardware.cpu.intel.updateMicrocode = true;

  hardware.keyboard.zsa.enable = true;

  networking.hostName = "pie"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Docker
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };


  # Set your time zone.
  time.timeZone = "Europe/Brussels";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver = {
    # X11 windowing system
    enable = true;

    # Keymap
    layout = "be";
    xkbVariant = "";

    # GNOME
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  # Enable flatpak
  services.flatpak.enable = true;

  # Configure console keymap
  console.keyMap = "be-latin1";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  programs.wireshark.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.pi = {
    isNormalUser = true;
    description = "pi";
    extraGroups = [ "networkmanager" "wheel" "wireshark" ];

    packages = with pkgs; [
      firefox
      signal-desktop
      vscode
      # Libreoffice
      libreoffice-still  # Stable version
      hunspell  # Hunspell dictionaries for language checking
      hunspellDicts.en_GB-large
      hunspellDicts.en_US
      hunspellDicts.fr-moderne
      hunspellDicts.nl_NL

      timetrap
      spotify
      sqlite
      git
      gh
      wireshark
      inetutils
      obsidian
      logseq
      tor-browser-bundle-bin
      jetbrains-toolbox
      gnome.gnome-software
      file
      wally-cli
      dig
      keymapp
      zsa-udev-rules
      protonvpn-gui
      spicetify-cli
      impression
    ];
  };

  services = {
    syncthing = {
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
  };

  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome.gnome-maps
    gnome.geary
  ];
  services.xserver.excludePackages = with pkgs; [
    xterm
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    (python3.withPackages my-python-packages)
    php
    cargo
    rustc
    clang
    wireguard-tools
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
