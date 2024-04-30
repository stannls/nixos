# System specific settings for my desktop machine
{ lib, config, pkgs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Hostname
  networking.hostName = "nixos";

  # Timezone
  time.timeZone = "Europe/Berlin";

  # Locale settings
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # X11 keymap
  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

  # Console keymap
  console.keyMap = "de";
}
