{ ... }:

# Enable flatpak and add the de facto repository
# Also see https://gitlab.com/Zaney/zaneyos from where I stole this

{
  services.flatpak.enable = true;
  /*
    systemd.services.flatpak-repo = {
      wantedBy = [ "multi-user.target" ];
      path = [ pkgs.flatpak ];
      script = ''
        flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
      '';
    };
  */
}
