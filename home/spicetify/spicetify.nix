{ pkgs, lib, spicetify-nix, ... }:
let
  spicePkgs = spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
  # allow spotify to be installed if you don't have unfree enabled already
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "spotify"
  ];

  # import the flake's module for your system
  imports = [ spicetify-nix.homeManagerModules.default ];

  # configure spicetify :)
  programs.spicetify =
    {
      enable = true;
      # dracula was removed from spicetify-nix, define it as an unpackaged theme
      theme = {
        name = "Dracula";
        src = pkgs.fetchFromGitHub {
          owner = "Darkempire78";
          repo = "Dracula-Spicetify";
          rev = "97bf149e7afbe408509862591a57f1d8e2dfc5d7";
          hash = "sha256-IS0A/5zTZou9yQJ0zpqAwiW2COt/TGoscN99WGFR9FA=";
        } + /Dracula;
        injectCss = false;
      };
#      colorScheme = "mocha";

      enabledExtensions = with spicePkgs.extensions; [
        fullAppDisplay
        shuffle # shuffle+ (special characters are sanitized out of ext names)
        hidePodcasts
        adblock
        autoSkipVideo
      ];
    };
}
