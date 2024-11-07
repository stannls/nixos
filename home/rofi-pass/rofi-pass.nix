{ config, pkgs, ... }:

{
  home.file.".config/rofi-pass/config".source = ./config;
  home.file.".config/rofi-pass/rofi-pass".source = ./rofi-pass;
}
