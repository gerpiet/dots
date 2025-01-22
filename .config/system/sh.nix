{ config, pkgs, ... }:

let myAliases = {
  ".." = "cd ..";
  "nix-unfree-develop" = "export NIXPKGS_ALLOW_UNFREE=1 && nix develop --impure";
};

in
{
  programs.bash = {
    shellAliases = myAliases;
  };
}