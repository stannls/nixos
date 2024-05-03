{pkgs, ...}: let
  callPackage = pkgs.callPackage;
in {
  nixpkgs.overlays = [(final: prev: {
    mypackages = {
      dracula-theme = callPackage ./dracula-theme.nix {};
    };
  })];
}
