{ inputs, outputs, config, pkgs, nix-colors, ... }:

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
    ./ranger/ranger.nix
    ./rofi-pass/rofi-pass.nix
    ./cargo/cargo.nix
    nix-colors.homeManagerModules.default
  ];

  colorScheme = nix-colors.colorSchemes.dracula;

  home.username = "yannis";
  home.homeDirectory = "/home/yannis";
  home.stateVersion = "23.11";

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
    ];
    config = {
      allowUnfree = true;
    };
  };

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
    nautilus
    discord
    thunderbird
    rustup
    jetbrains.idea-ultimate
    libnotify
    yubioath-flutter
    vscodium
    (python3.withPackages (python-pkgs: [
      python-pkgs.pwntools
      python-pkgs.jedi
    ]))
    signal-desktop
    xdg-utils
    maven
    jdk21
    lutris-free
    grim
    slurp
    rhythmbox
    nicotine-plus
    (gdb.override {
      enableDebuginfod = true;
    })
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
    nixpkgs-fmt
    desmume
    yubikey-manager
    ranger
    ueberzugpp
    pandoc
    dracula-theme
    inputs.nixify.defaultPackage."${pkgs.system}"
    inputs.bandrip.defaultPackage."${pkgs.system}"
    libreoffice
    clang-tools
    wineWowPackages.stable
    winetricks
    anki
    docker-compose
    pwninit
    patchelf
    pokemmo
    element-desktop
    poppler_utils
    ripgrep
    calibre
    mpv
    vlc
    ffmpegthumbnailer
    eog
    tmux
    gnome-calendar
    radare2
    prismlauncher
    jflap
    hyprcursor
    gnumake
    pdfpc
    tree
    wtype
    flameshot
    eclipses.eclipse-sdk
    mattermost-desktop
    dbus
    glib
    rars
    jetbrains.webstorm
    ungoogled-chromium
    playwright-driver.browsers
    jetbrains.rust-rover
    cmake
    reaper
    teams-for-linux
    mold
  ];

  xdg.mimeApps.defaultApplications = {
    "application/pdf" = "librewolf.desktop";
  };

  xdg.desktopEntries.disable-notifications = {
    name = "Disable Notifications";
    exec = "dunstctl set-paused true";
    terminal = false;
  };

  xdg.desktopEntries.enable-notifications = {
    name = "Enable Notifications";
    exec = "dunstctl set-paused false";
    terminal = false;
  };


  xdg.userDirs.createDirectories = true;
  xdg.userDirs.enable = true;

  # Zsh config
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    shellAliases = {
      update-desktop = "sudo nixos-rebuild --flake /home/yannis/nixos-config#desktop switch";

      update-laptop = "sudo nixos-rebuild --flake /home/yannis/nixos-config#laptop switch";
      neofetch = "fastfetch";
    };
    history.size = 10000;
    history.path = "/home/yannis/.zsh_history";

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
    # Make nix develop use zsh
    initExtra = ''
      	function nix() {
      		if [[ "$1" == "develop" ]]; then
      			shift 1
      			command nix develop -c zsh "$@"
      		else
      			command nix "$@"
      		fi
      	}
      	'';

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
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
    theme = {
      name = "Dracula";
      package = pkgs.dracula-theme;
    };
    cursorTheme = {
      name = "apple_cursor";
      package = pkgs.apple-cursor;
    };
    iconTheme = {
      name = "Dracula";
      package = pkgs.dracula-theme;
    };
  };
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "Dracula";
    };
    "org/freedesktop/appearance" = {
      color-scheme = "prefer-dark";
      gtk-theme = "Dracula";
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
