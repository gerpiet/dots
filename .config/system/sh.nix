/**
  * The shell configuration
*/

{ pkgs, ... }:

let
  myAliases = {
    ".." = "cd ..";
    "dots" = "git --git-dir=/home/pi/.cfg/ --work-tree=/home/pi";
    "nix-unfree-develop" = "export NIXPKGS_ALLOW_UNFREE=1 && nix develop --impure";
    "nix-unfree-shell" = "export NIXPKGS_ALLOW_UNFREE=1 && nix shell --impure";
  };
in
{
  users.users.pi.shell = pkgs.bash;
  programs.bash = {
    shellAliases = myAliases;
  };
}
