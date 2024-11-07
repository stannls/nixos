{ lib, config, pkgs, ... }:
{
  imports = [
  ];

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Limit max jobs
  nix.settings.max-jobs = 10;

  # Optimise store after every build
  nix.settings.auto-optimise-store = true;

  # Enable networking
  networking.networkmanager.enable = true;

  # Open port 8080
  networking.firewall.allowedTCPPorts = [ 8080 ];

  # Define a user account.
  users.users.yannis = {
    isNormalUser = true;
    description = "Yannis Storrer";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ ];
  };
  users.defaultUserShell = pkgs.zsh;

  # System packages
  environment.systemPackages = with pkgs; [
    git
    wget
    usbutils
    udiskie
    udisks
    pinentry
    pinentry-gnome3
    unzip
    qemu
    ntfs3g
    fuse
    texlive.combined.scheme-full
    quickemu
    xdg-user-dirs
    jmtpfs
    file
    perf-tools
    gcc
    killall
    brightnessctl
    man-pages
    man-pages-posix
  ];

  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  programs.dconf.enable = true;
  services.gnome.evolution-data-server.enable = true;
  services.gnome.gnome-online-accounts.enable = true;
  services.gnome.gnome-keyring.enable = true;

  services.printing.enable = true;
  services.blueman.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  programs.evince.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Fonts
  fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true;

    # Font packages
    packages = with pkgs; [
      iosevka
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      liberation_ttf
      fira-code
      fira-code-symbols
      mplus-outline-fonts.githubRelease
      dina-font
      proggyfonts
      (nerdfonts.override {
        fonts = [
          "SpaceMono"
          "JetBrainsMono"
          "DejaVuSansMono"
        ];
      })
    ];
  };

  # Use zsh
  programs.zsh.enable = true;

  # Use Neovim as default editor
  programs.neovim = {
    viAlias = true;
    vimAlias = true;
    enable = true;
    defaultEditor = true;
  };

  # Install Hyprland systemwide
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Enable steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  security.rtkit.enable = true;

  # Use pipewire for audio
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Yubikey config
  services.udev.packages = [ pkgs.yubikey-personalization ];

  # Udisks sevices
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  # Gnupg stuff
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-gtk2;
  };
  programs.ssh.startAgent = false;
  services.pcscd.enable = true;
  environment.shellInit = ''
        	gpg-connect-agent /bye
        	export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
        	gpgconf --launch gpg-agent
    		export GTK_THEME=Dracula
      	'';

  # Pam config for swaylock
  security.pam.services.swaylock = {
    text = ''
        	auth include login
      	'';
  };

  # Power management
  services.tlp.enable = true;

  # GTK-Theme stuff
  environment.etc."xdg/gtk-2.0/gtkrc".text = ''
      	gtk-theme-name = "Dracula"
    	'';
  environment.etc."xdg/gtk-3.0/settings.ini".text = ''
      	[Settings]
      	gtk-theme-name = Dracula
    	'';

  virtualisation.virtualbox.host.enable = true;

  # Settings for dynamically linked programs
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    zlib
    xorg.libX11
    xorg.libXxf86vm
    libGL
    gtk2
    gtk3
    xorg.libXtst
    xorg.libXext
    gdk-pixbuf
    glib
    gperf
    xorg.libXrender
    xorg.libXi
    freetype
    pcsclite
  ];

  system.stateVersion = "23.11";
}
