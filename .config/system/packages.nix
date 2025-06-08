/**
  * A list of all packages. If one packages changes, gets replaced, ..., only this file changes.
*/

{
  inputs,
  pkgs,
  ...
}:

{
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
      localsend
      mission-center # Instead of gnome-system-monitor
      papers # Instead of evince
      pika-backup
      protonvpn-gui
      shortwave
      signal-desktop
      timewarrior
      tmux
      tor-browser
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
      gnome-maps
      gnome-music
      gnome-system-monitor # Replaced by mission-center
      gnome-tour
      simple-scan
      snapshot
      yelp
    ]
  );

  services.xserver.excludePackages = with pkgs; [ xterm ];
}
