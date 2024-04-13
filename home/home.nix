{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "yannis";
  home.homeDirectory = "/home/yannis";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.alacritty
    pkgs.swaylock
    pkgs.waybar
    pkgs.wofi
    pkgs.fastfetch
    pkgs.librewolf
    pkgs.pulsemixer
    pkgs.pass-wayland
    pkgs.yarn
    pkgs.nodejs_21
    pkgs.swaybg
    pkgs.wl-clipboard
	pkgs.gnome.nautilus
	pkgs.discord
	pkgs.thunderbird
	pkgs.rustup
	pkgs.jetbrains.idea-ultimate
	pkgs.steam
	pkgs.dunst
	pkgs.libnotify
	pkgs.spotify
	pkgs.openjdk
	pkgs.yubikey-manager
	pkgs.yubioath-flutter
	(pkgs.python3.withPackages (python-pkgs: [
    ]))
  ];
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    shellAliases = {
      update = "sudo nixos-rebuild switch";
      update-user = "home-manager switch";
    };
    history.size = 10000;
    history.path = "zsh/history";
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "gradle" "npm" "pass" "rust"];
      theme = "agnoster";
    };
  };
  programs.git = {
    enable = true;
    userName = "Yannis Storrer";
    userEmail = "yannis.storrer@web.de";
  };
  services.gpg-agent = {
      enable = true;
      enableSshSupport = true;
      defaultCacheTtl = 600;
      defaultCacheTtlSsh = 600;
      maxCacheTtl = 7200;
      maxCacheTtlSsh = 7200;
      sshKeys = [ "9FD2B7C0D07D8F1E6357129E9FA45CC7F6DFA7E7" ];
      extraConfig = ''
        allow-preset-passphrase
      '';
    };
	gtk = {
      enable = true;
      gtk3.extraConfig.gtk-decoration-layout = "menu:";
      theme = {
        name = "Dracula";
      };
      iconTheme = {
        name = "Dracula";
      };
    };
	home.sessionVariables.GTK_THEME = "Dracula";

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
   ".config/hypr" = {
    source = ./hypr;
    recursive = true;
   };
   ".config/wofi" = {
    source = ./wofi;
    recursive = true;
   };
   ".config/waybar" = {
    source = ./waybar;
    recursive = true;
   };
   ".config/nvim" = {
     source = ./nvim;
     recursive = true;
   };
   ".config/swaylock" = {
     source = ./swaylock;
     recursive = true;
   };
   ".config/dunst" = {
	  source = ./dunst;
	  recursive = true;
   };
   ".config/alacritty/alacritty.toml".source = ./alacritty/alacritty.toml;
   "Pictures/Backgrounds/flowers.jpg".source = ./flowers.jpg;
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/yannis/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
  }; 

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
