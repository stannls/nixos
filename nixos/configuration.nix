{ lib, config, pkgs, ... }:
{
  imports =
    [
		./hardware-configuration.nix
    ];

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  networking.hostName = "nixos"; 

  # Enable networking
  networking.networkmanager.enable = true;
  # Set your time zone.
  time.timeZone = "Europe/Berlin";
  # Select internationalisation properties.
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

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "us";

  # Define a user account.
  users.users.yannis = {
    isNormalUser = true;
    description = "Yannis Storrer";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
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
	texlive.combined.scheme-medium
	quickemu
	xdg-user-dirs
  ];
 # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  # Fonts
  fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true;

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
        (nerdfonts.override { fonts = [
			"SpaceMono"
	  		"JetBrainsMono"
	  		"DejaVuSansMono"
	]; })	
    ];
  };

  programs.zsh.enable = true;

  programs.neovim = {
    viAlias = true;
    vimAlias = true;
    enable = true;
    defaultEditor = true;
  };
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
	pinentryPackage  = pkgs.pinentry-gtk2;
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
  services.tlp.enable = true;
  environment.etc."xdg/gtk-2.0/gtkrc".text = ''
    gtk-theme-name = "Dracula"
  '';

  environment.etc."xdg/gtk-3.0/settings.ini".text = ''
    [Settings]
    gtk-theme-name = Dracula
  '';
  environment.etc = {
  "xdg/user-dirs.defaults".text = ''
    DESKTOP=Desktop
    DOWNLOAD=Downloads
    TEMPLATES=Templates
    DOCUMENTS=Documents
    MUSIC=Music
    PICTURES=Pictures
    VIDEOS=Videos
  '';
};
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
	];

  system.stateVersion = "23.11";
}
