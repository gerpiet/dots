/**
  * A list of all packages. If one packages changes, gets replaced, ..., only this file changes.
*/

{
  inputs,
  pkgs,
  ...
}:

{
  nixpkgs.overlays = [
    (final: _prev: {
      protonvpn_working = import (builtins.fetchTarball {
        url = "https://github.com/NixOS/nixpkgs/archive/ba29026f127183f946147a70eeb7bd79fec207da.tar.gz";
        sha256 = "sha256:09abiacyf1ar0c9q6cvmks9kp6vmwzd5bppxzyw0mr8h4qsh26ia";
      }) { inherit (final) system; };
    })
  ];

  users.users.pi.packages =
    (with pkgs; [
      # Proprietary
      discord
      keymapp
      obsidian
      spotify

      # Open source
      bitwarden-desktop
      chromium
      decibels # Instead of gnome-music
      file
      firefox
      fractal
      fragments
      gh
      git
      gnome-extension-manager
      gnome-secrets
      gnome-software

      hunspell
      hunspellDicts.en_GB-large
      hunspellDicts.en_US
      hunspellDicts.fr-moderne
      hunspellDicts.nl_NL

      imhex
      impression
      libreoffice-still # Stable version
      mission-center # Instead of gnome-system-monitor
      papers # Instead of evince
      pika-backup
      protonvpn_working.protonvpn-gui
      shortwave
      signal-desktop
      timewarrior
      tmux
      tor-browser-bundle-bin
      wireshark
      zsa-udev-rules

      # Editors
      package-version-server # Needed for Zed
      vscode
      zed-editor

      # Programming language tools
      clang-tools
      nixd
      nixfmt-rfc-style
      (python312.withPackages (
        python-pkgs: with python-pkgs; [
          python-lsp-server
        ]
      ))
      rust-analyzer
    ])
    ++ [ inputs.zen-browser.packages."${pkgs.system}".default ];

  environment.gnome.excludePackages = (
    with pkgs;
    [
      epiphany
      evince # Replaced by papers
      geary
      gnome-connections
      gnome-contacts
      gnome-font-viewer
      gnome-logs
      gnome-music # Replaced by decibels
      gnome-system-monitor # Replaced by mission-center
      gnome-tour
      gnome-maps
      simple-scan
      snapshot
      yelp
    ]
  );

  services.xserver.excludePackages = with pkgs; [ xterm ];
}
