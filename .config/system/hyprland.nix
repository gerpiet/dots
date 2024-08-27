{ config, pkgs, ... }:

{
  # Enable Hyprland
  programs.hyprland.enable = true;

  users.users.pi.packages = with pkgs; [
    dunst
    libnotify
    playerctl
    tofi
    waybar
  ];
}