{ config, pkgs, ... }:

let myAliases = { ".." = "cd .."; };

in
{
  programs.bash = {
    shellAliases = myAliases;
  };
}