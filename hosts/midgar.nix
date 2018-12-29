{ pkgs, ... }:

{
  imports =
    [ 
      ./core.nix
      ./hardware-configuration.nix
      ./services/xserver.nix
    ];

  networking.hostName = "midgar"; # Define your hostname.

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";
 
  # Enables wireless support via wpa_supplicant.
  networking.wireless.enable = true; 

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable bluetooth
  hardware.bluetooth = {
	  enable = true;
	  powerOnBoot = true;
  };

  # Firewall
  networking.firewall.enable = true;

  environment.systemPackages = with pkgs; [
    compton
    scrot
    tree
  ];
}
