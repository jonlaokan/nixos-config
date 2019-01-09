{ pkgs, ... }:

{
  imports =
    [ 
      ./core.nix
      ./hardware-configuration.nix
      ./services/xserver.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Touchpad support
  services.xserver.synaptics = {
    enable = true;
    dev = "/dev/input/event*";
    twoFingerScroll = true;
    accelFactor = "0.001";
    buttonsMap = [ 1 3 2 ];
  };

  security.sudo.enable = true;

  networking.hostName = "midgar"; 
  networking.networkmanager.enable = true;
  networking.firewall.enable = true;

  nixpkgs.config.allowUnfree = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable bluetooth
  hardware.bluetooth = {
	  enable = true;
	  powerOnBoot = true;
  };

  # Specific services
  services.tlp.enable = true;
  services.thermald.enable = true;

  environment.systemPackages = with pkgs; [
    # Tool
    kbdlight
    playerctl
    tlp
    thermald
  ];
}
