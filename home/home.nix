{ config, pkgs, nix-colors, ... }:

{
  imports = [
    ./alacritty/alacritty.nix
    ./beets/beets.nix
    ./dunst/dunst.nix
    ./rofi/rofi.nix
    ./fastfetch/fastfetch.nix
    ./spicetify/spicetify.nix
    ./cava/cava.nix
    ./hypridle/hypridle.nix
    nix-colors.homeManagerModules.default
  ];

  colorScheme = nix-colors.colorSchemes.dracula;

  home.username = "yannis";
  home.homeDirectory = "/home/yannis";
  home.stateVersion = "23.11";

  # User packages
  home.packages = with pkgs; [
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
    libnotify
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
    gdb
    ghidra
    pkg-config
    openssl
    feh
    chromaprint
    lollypop
    openvpn
    rofi
    bottom
    pulseaudio
    playerctl
    hypridle
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Zsh config
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    shellAliases = {
      update-desktop = "sudo nixos-rebuild --flake .#desktop switch";
      neofetch = "fastfetch";
    };
    history.size = 10000;
    history.path = "/home/yannis/zsh/history";

    # Nix shell zsh plugin
    plugins = [
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.8.0";
          sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
        };
      }
    ];

    # Oh-my-zsh settings
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "gradle"
        "npm"
        "pass"
        "rust"
      ];
      theme = "agnoster";
    };
  };

  # Git settings
  programs.git = {
    enable = true;
    userName = "Yannis Storrer";
    userEmail = "yannis.storrer@web.de";
    signing.key = "4D4F489A421B7DBB";
    extraConfig = {
      pull.rebase = true;
      commit.gpgsign = true;
      init.defaultBranch = "main";
    };
  };

  # Gpg-agent conf for ssh auth
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

  # More gtk-theme settings
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

  # Config sourcing. This might be replaced with home manager configuration in the near future.
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
    "Pictures/Backgrounds/flowers.jpg".source = ./flowers.jpg;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
}
