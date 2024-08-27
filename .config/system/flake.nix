{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    firefox-nightly.url = "github:nix-community/flake-firefox-nightly";
    zen-browser.url = "github:MarceColl/zen-browser-flake";
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations = {
        pie = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs;};
          modules = [ 
            ./configuration.nix
            ./docker.nix
            ./flatpak.nix
            ./hyprland.nix
            ./sh.nix
            ./syncthing.nix
            ./vmtest.nix
          ];
        };
      };
    };
}
