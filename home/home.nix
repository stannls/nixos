{ config, pkgs, ... }:

{
  home.username = "yannis";
  home.homeDirectory = "/home/yannis";
  home.stateVersion = "23.11"; 

  # User packages
  home.packages = with pkgs; [
    alacritty
    swaylock
    waybar
    wofi
    fastfetch
    librewolf
    pulsemixer
    pass-wayland
    yarn
    nodejs
    swaybg
    wl-clipboard
	gnome.nautilus
	discord
	thunderbird
	rustup
	jetbrains.idea-ultimate
	dunst
	libnotify
	spotify
	yubikey-manager
	yubioath-flutter
	vscodium
	(python3.withPackages (python-pkgs: [
    ]))
	signal-desktop
	xdg-utils
	maven
	jdk21
	lutris
	grim
	slurp
	rhythmbox
	nicotine-plus
	beets
	gdb
	ghidra
	pkg-config
	openssl
	feh
	chromaprint
	lollypop
	openvpn
  ];
  # Allow unfree packages
  nixpkgsconfig.allowUnfree = true;
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    shellAliases = {
      update = "sudo nixos-rebuild switch";
      update-user = "home-manager switch";
    };
    history.size = 10000;
    history.path = "/home/yannis/zsh/history";
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
	signing.key = "4D4F489A421B7DBB";
	extraConfig = {
		commit.gpgsign = true;
		init.defaultBranch = "main";
	};
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
   ".config/beets/config.yaml".source = ./beets/config.yaml;
   "Pictures/Backgrounds/flowers.jpg".source = ./flowers.jpg;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  }; 

  programs.home-manager.enable = true;
}
