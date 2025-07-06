/**
  * Package set
  * As there are often changes to it, packages have their own file to keep the history clean.
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
      buffer
      chromium
      file
      firefox
      fractal
      fragments
      gh
      git
      gnome-extension-manager
      # gnome-secrets disable temporarily as it is not used at the moment until https://nixpk.gs/pr-tracker.html?pr=418407 is ready
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
      logseq
      mission-center # Instead of gnome-system-monitor
      papers # Instead of evince; should be a core application in Gnome 49 https://thisweek.gnome.org/posts/2025/07/twig-207/#gnome-core-apps-and-libraries
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
