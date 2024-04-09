{ config, pkgs, ... }:

{
  services.vikunja.enable = true;
  services.vikunja.frontendScheme = "https";
  services.vikunja.frontendHostname = "localhost";
}