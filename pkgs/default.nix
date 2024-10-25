# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs: {
  dracula-gtk-theme = pkgs.callPackage ./dracula-gtk-theme.nix { };
  yubikey-manager = pkgs.callPackage ./yubikey-manager.nix { };
  yubioath-flutter = pkgs.callPackage ./yubioath-flutter/default.nix { };
  pokemmo = pkgs.callPackage ./pokemmo.nix { };
  jflap = pkgs.callPackage ./jflap/default.nix { };
}
