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
      bitwarden-desktop
      chromium
      dconf-editor
      discord
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
      keymapp
      libreoffice-still # Stable version
      mission-center # Instead of gnome-system-monitor
      obsidian
      papers # New Gnome PDF viewer
      pika-backup
      protonvpn-gui
      signal-desktop
      spotify
      timewarrior
      tmux
      tor-browser-bundle-bin
      vscode
      wireshark
      zed-editor
      zsa-udev-rules

      # Programming
      clang-tools
      nixd
      nixfmt-rfc-style
      rust-analyzer
    ])
    ++ [ inputs.zen-browser.packages."${pkgs.system}".default ];

  environment.gnome.excludePackages = (
    with pkgs;
    [
      epiphany
      geary
      gnome-connections
      gnome-remote-desktop
      gnome-system-monitor
      gnome-tour
      gnome-maps
    ]
  );

  services.xserver.excludePackages = with pkgs; [ xterm ];
}
