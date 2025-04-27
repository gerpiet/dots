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
  environment.variables = {
    # XDG Base Directory specification
    # See:
    #  - https://wiki.archlinux.org/title/XDG_Base_Directory#Support
    #  - https://github.com/b3nj5m1n/xdg-ninja
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_STATE_HOME = "$HOME/.local/state";
    XDG_CACHE_HOME = "$HOME/.cache";

    CARGO_HOME = "$XDG_DATA_HOME/cargo";
    HISTFILE = "$XDG_STATE_HOME/bash/history";
    NPM_CONFIG_CACHE = "$XDG_CACHE_HOME/npm";
    NPM_CONFIG_INIT_MODULE = "$XDG_CONFIG_HOME/npm/config/npm-init.js";
    NPM_CONFIG_TMP = "$XDG_RUNTIME_DIR/npm";
    RUSTUP_HOME = "$XDG_DATA_HOME/rustup";
  };
}
