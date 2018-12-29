{ pkgs, ...}:

{

  # Enable the X11 windowing system.
   services.xserver.enable = true;
   services.xserver.autorun = true;
   services.xserver.layout = "us";
   services.xserver.xkbVariant = "colemak";
   services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.
  # services.xserver.libinput.enable = true;
  security.sudo.enable = true;

  services.xserver.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
    extraPackages = haskellPackages: [
    	haskellPackages.xmonad-contrib
	haskellPackages.xmonad-extras
	haskellPackages.xmonad
    ];
  };
 
  # Use lightdm
  services.xserver.displayManager.lightdm = {
	  enable = true;
	  greeters.gtk.indicators = [ "~host" "~spacer" "~spacer" "~a11y" "~session" "~power"];
  };

  fonts = {
    enableFontDir = true;
	fonts = with pkgs; [
	  #nerdfonts
	  opensans-ttf
	  siji
	];
  };

}
