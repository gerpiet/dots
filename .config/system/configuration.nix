/**
  * General/main configuration
*/

{ ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Boot and hardware
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    initrd.luks.devices."luks-4528c4e5-31eb-48d7-9eff-e4cb56c31799".device =
      "/dev/disk/by-uuid/4528c4e5-31eb-48d7-9eff-e4cb56c31799";

    # NTFS support
    supportedFilesystems.ntfs = true;
  };

  hardware = {
    cpu.intel.updateMicrocode = true;
    keyboard.zsa.enable = true;
  };

  # Nix and Nixpkgs
  nix.gc = {
    automatic = true;
    dates = "monthly";
    options = "--delete-older-than 30d";
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.config = {
    # Allow unfree packages
    allowUnfree = true;

    # Patch for wpa_supplicant to make school WiFi work
    packageOverrides = pkgs: rec {
      wpa_supplicant = pkgs.wpa_supplicant.overrideAttrs (attrs: {
        patches = attrs.patches ++ [ ./patches/wpa_supplicant/legacy-wifi.patch ];
      });
    };

    permittedInsecurePackages = [ "electron-27.3.11" ];
  };

  # General configuration
  networking.hostName = "pie";

  time.timeZone = "Europe/Brussels";

  i18n.defaultLocale = "en_US.UTF-8";

  services = {
    # Desktop environment  and input
    xserver = {
      enable = false;

      # Enable the GNOME Desktop Environment.
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;

      # Configure keymap in X11
      xkb = {
        layout = "be";
        variant = "";
      };
    };

    gnome.gnome-remote-desktop.enable = false; # Default false, but enabled by Gnome

    printing.enable = true;

    # Enable sound with pipewire.
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };

    openssh.enable = true;
  };

  security.rtkit.enable = true;

  # Configure console keymap
  console.keyMap = "be-latin1";

  programs = {
    wireshark.enable = true;
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  users.users.pi = {
    isNormalUser = true;
    description = "pi";
    extraGroups = [
      "networkmanager"
      "wheel"
      "wireshark"
    ];
    initialPassword = "pi";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
