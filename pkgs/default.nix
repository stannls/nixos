# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs: {
  dracula-gtk-theme = pkgs.callPackage ./dracula-gtk-theme.nix { };
  yubikey-manager = pkgs.callPackage ./yubikey-manager.nix { };
  bandrip = pkgs.callPackage ./bandrip.nix { };
  nixify = pkgs.callPackage ./nixify.nix { };
}
