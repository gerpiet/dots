/**
  * The shell configuration
*/

{ pkgs, ... }:

let
  aliases = {
    ".." = "cd ..";
    "dots" = "git --git-dir=/home/pi/.cfg/ --work-tree=/home/pi";
    "nix-unfree-develop" = "export NIXPKGS_ALLOW_UNFREE=1 && nix develop --impure";
    "nix-unfree-shell" = "export NIXPKGS_ALLOW_UNFREE=1 && nix shell --impure";
    # Toggle a comment in the taskrc file that imports a light theme
    # Thanks to https://stackoverflow.com/a/72615471 by https://stackoverflow.com/users/4179107/byrontaaka
    "task-theme-toggle" =
      "sed -Ei 's/^include light-256\.theme/#&/;t;s/^#(include light-256\.theme)/\\1/' /home/pi/.config/task/taskrc";
  };
  baseEnvVariables = {
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_STATE_HOME = "$HOME/.local/state";
    XDG_CACHE_HOME = "$HOME/.cache";
  };
in
{
  users.users.pi.shell = pkgs.bash;
  programs.bash = {
    shellAliases = aliases;
  };
  environment.variables = {
    # XDG Base Directory specification
    # See:
    #  - https://wiki.archlinux.org/title/XDG_Base_Directory#Support
    #  - https://github.com/b3nj5m1n/xdg-ninja
    CARGO_HOME = baseEnvVariables.XDG_DATA_HOME + "/cargo";
    HISTFILE = baseEnvVariables.XDG_STATE_HOME + "/bash/history";
    NPM_CONFIG_CACHE = baseEnvVariables.XDG_CACHE_HOME + "/npm";
    NPM_CONFIG_INIT_MODULE = baseEnvVariables.XDG_CONFIG_HOME + "/npm/config/npm-init.js";
    NPM_CONFIG_TMP = "$\{XDG_RUNTIME_DIR}/npm";
    RUSTUP_HOME = baseEnvVariables.XDG_DATA_HOME + "/rustup";
  };
}
