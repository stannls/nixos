# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs: {
  dracula-theme = pkgs.callPackage ./dracula-theme.nix { };
  yubikey-manager = pkgs.callPackage ./yubikey-manager.nix { };
}
