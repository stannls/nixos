# nixos
This repo contains my NixOs configuration with flakes and home-manager. It currently runs Hyprland as a window manager and contains configuration for various programs.

## Programs

Currently this repo houses configurations for the following programs:
- alacritty
- cava
- dunst
- hyprland (Together with a script for wallpapers and password manager dialog)
- neovim (with coc as language server backend)
- waybar
- wofi
- swaylock
- beets

## Pictures
### 2 Screen Hyprland Setup
![Image 2-Screen](https://i.imgur.com/YEHttif.png)

### Neovim
![Image Neovim](https://i.imgur.com/nMGD04N.png)

## Install

The configuration contains an individual flake for each installation. The hardware specific configurations are stored in nixos/name-of-installation/configuration.nix and nixos/name-of-installation/hardware-configuration.nix. To install simply adjust one of these installations, link the folder to /etc/nixos and run `sudo nixos-rebuild --flake .#name-of-installation switch`.
