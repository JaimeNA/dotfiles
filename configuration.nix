# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <home-manager/nixos>
    ];

  # Use systemd boot
  boot.loader = {
	systemd-boot.enable = true;
  };

  # Use the GRUB 2 boot loader.
  # boot.loader.grub.enable = true;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  #  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  # boot.loader.grub.devices = [ "nodev" ]; # or "nodev" for efi only

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "jasha-desktop"; # Define your hostname.

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Argentina/Buenos_Aires";

  # Shell
  programs.fish.enable = true;

  # Configure user
  users.users.jasha = {
	isNormalUser = true;
	description = "jasha";
	extraGroups = ["wheel" "video"]; # Sudo access and multimedio keyrings
	shell = pkgs.fish;
	home = "/home/jasha";

  };

  # Home Manager
  # This saves an extra Nixpkgs evaluation, adds consistency, 
  # and removes the dependency on NIX_PATH, which is otherwise used for importing Nixpkgs.
  home-manager.useGlobalPkgs = true;

  # Because I’m not installing it “stand alone”, 
  # I’m not going to have a home-manager command nor will I have a separate 
  # ~/.config/home-manager/home.nix file.
  home-manager.users.jasha = { config, pkgs, ... }: {
	
	# Dark theme
	dconf = {
	    enable = true;
	    settings = {
	      	"org/gnome/desktop/interface" = {
			color-scheme = "prefer-dark";
	      	};
	    };
	};

	gtk = {
	      enable = true;
	      theme = {
			name = "Adwaita-dark";
			package = pkgs.gnome-themes-extra;
	      };
	};

  	# Home Manager needs a bit of information about you and the
  	# paths it should manage.
  	home.username = "jasha";
  	home.homeDirectory = "/home/jasha";

  	# Packages that should be installed to the user profile.
  	home.packages = with pkgs; [
    		git
    		gimp
    		imv
		mpv
    		cava
		thunderbird
		nnn
		fastfetch
		bemenu
		kitty
		neovim
		firefox
		chromium
		autotiling
		vesktop
  	];

  	# This value determines the Home Manager release that your
  	# configuration is compatible with. This helps avoid breakage
  	# when a new Home Manager release introduces backwards
  	# incompatible changes.
  	#
  	# You can update Home Manager without changing this value. See
  	# the Home Manager release notes for a list of state version
  	# changes in each release.
  	home.stateVersion = "25.11";

  	# Let Home Manager install and manage itself.
  	programs.home-manager.enable = true;

  	# Cursor theme
	home.file.".icons/default".source = "${pkgs.vimix-cursors}/share/icons/Vimix-cursors";	
  };

  # Also set dark theme for QT
  qt = {
	enable = true;
	platformTheme = "gnome";
	style = "adwaita-dark";
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
  services.pipewire = {
     enable = true;
     pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users.alice = {
  #   isNormalUser = true;
  #   extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  #   packages = with pkgs; [
  #     tree
  #   ];
  # };

  # programs.firefox.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
	wl-clipboard 
	mako # Notification utility
  	vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
	bluez
  	wget
	rustc
	cargo
	gcc
	gpp
	cmake
	gnumake
  ];

  
  # Fonts
  fonts.packages = with pkgs; [ 
    nerd-fonts.roboto-mono
    nerd-fonts.jetbrains-mono
  ];

  # Enables Gnome keyring to store secrets for applications
  services.gnome.gnome-keyring.enable = true;

  # Enable sway
  programs.sway = {
	enable = true;
	wrapperFeatures.gtk = true;
  };

  # Enable waybar
  programs.waybar = {
	enable = true;
  };

  # For Home Manager
  security.polkit.enable = true;

  # Add a greeter
  services.greetd = {
	enable = true;
	settings = {
		default_session = {
			command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd sway";
			user = "jasha";
		};
  	};
  };

  # Enable keyrings for audio and video
  programs.light.enable = true;

  # Only allow the unfree packages of steam
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-unwrapped"
  ];

  # Enable steam to be installed
   programs.steam = {
	enable = true;
	remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
	dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
   }; 

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.11"; # Did you read the comment?



}

