{pkgs, ...}: let
  callPackage = pkgs.callPackage;
in {
  nixpkgs.overlays = [(final: prev: {
    mypackages = {
      dracula = callPackage ./dracula.nix {};
    };
  })];
}
