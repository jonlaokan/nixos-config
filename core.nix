{ config, pkgs, lib, ... }:

with lib;

{

# This value determines the NixOS release with which your system is to be
# compatible, in order to avoid breaking some software such as database
# servers. You should change this only after NixOS release notes say you
# should.
	system.stateVersion = "18.09"; # Did you read the comment?

# Keep only the last 500MiB of systemd journal
	services.journald.extraConfig = "SystemMaxUse=500M";

# Collect nix store garbage and optimise daily.
	nix.gc.automatic = true;
	nix.optimise.automatic = true;

# Enable passwd and co.
	users.mutableUsers = true;

# Select internationalisation properties.
	i18n = {
		consoleFont = "Lat2-Terminus16";
		consoleKeyMap = "us";
		defaultLocale = "en_US.UTF-8";
	};

# Set your time zone.
	time.timeZone = "Europe/Paris";

	networking.firewall = {
		allowPing = true;
	};

	services.openssh = {
		enable = true;
		passwordAuthentication = true;
	};

  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.jonlaokan = {
     isNormalUser = true;
     uid = 1000;
     home = "/home/jonlaokan";
     createHome = true;
     extraGroups = [ "wheel" "networkmanager" ];
   };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
   environment.systemPackages = with pkgs;
     let
	core = [
	     wget
	     vim
	     neovim
	     python36Packages.neovim
	     nmap
	     htop
	     neofetch
	     man-pages
	     playerctl
	     stow
	     unzip
	     #scrot 
	     ranger
	     #tree
	];

     noxserver = [];

     xserver = [
	     anki
	     firefox
	     qutebrowser
	     zathura
	     kitty
	     feh
	     mpv
	     haskellPackages.xmobar
     ];

     in core ++ (if config.services.xserver.enable then xserver else noxserver);
}
