# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, inputs, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Automatically upgrade and garbage collect.
  system.autoUpgrade = {
    enable = true;
    operation = "boot";
    flake = inputs.self.outPath;
    flags = [
      "--update-input"
      "nixpkgs"
      "-L"  # print build logs
    ];
    dates = "15:00";
  };

  nix.gc = {
    automatic = true;
    dates = "Mon 14:00";
    options = "--delete-older-than 30d";
  };

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

  # NTFS support
  boot.supportedFilesystems = [ "ntfs" ];

  hardware.cpu.intel.updateMicrocode = true;

  hardware.keyboard.zsa.enable = true;

  boot.initrd.luks.devices."luks-c4865783-788f-40a1-929a-56f06233bfef".device = "/dev/disk/by-uuid/c4865783-788f-40a1-929a-56f06233bfef";
  networking.hostName = "pie"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # ^^^ Enabled by Gnome ^^^

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Brussels";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "be";
    variant = "";
  };

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

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable touchpad support (enabled default in most desktopManager).
  # Already enabled by Gnome
  # services.xserver.libinput.enable = true;

  programs.wireshark.enable = true;

  users.users.pi = {
    isNormalUser = true;
    description = "pi";
    extraGroups = [ "networkmanager" "wheel" "wireshark" ];
    shell = pkgs.bash;
    initialPassword = "pi";
    packages = with pkgs; [
      discord
      firefox
      file
      gh
      git
      gnome.gnome-software

      hunspell
      hunspellDicts.en_GB-large
      hunspellDicts.en_US
      hunspellDicts.fr-moderne
      hunspellDicts.nl_NL

      inetutils
      impression
      jetbrains-toolbox
      keymapp
      libreoffice-still  # Stable version
      logseq
      obsidian
      protonvpn-gui
      signal-desktop
      spicetify-cli
      spotify
      tor-browser-bundle-bin
      typst
      vscode
      wireshark
      zsa-udev-rules
      # Temporary workaround because Spotify doesn't work on X
      # (writeShellScriptBin "spotify" ''exec ${spotify}/bin/spotify --enable-features=UseOzonePlatform --ozone-platform=wayland'')
      # ^^^Deleting the cache directory for Spotify fixed it^^^
    ];
  };

  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome.gnome-maps
    gnome.geary
    epiphany
  ];

  services.xserver.excludePackages = with pkgs; [
    xterm
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    php
    cargo
    clippy
    rustc
    rust-analyzer
    clang
    wireguard-tools
    R
    rstudio
    rustfmt
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
  system.stateVersion = "23.11"; # Did you read the comment?

}
