{ pkgs, ...}:

{
  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    autorun = true;
    layout = "us";
    xkbVariant = "colemak";
    xkbOptions = "eurosign:e";

    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      extraPackages = haskellPackages: [
        haskellPackages.xmonad-contrib
        haskellPackages.xmonad-extras
        haskellPackages.xmonad
      ];
    };

    displayManager.lightdm = {
      enable = true;
      greeters.gtk.indicators = [ "~host" "~spacer" "~spacer" "~a11y" "~session" "~power"];
    };
  };

  services.redshift = {
    enable = true; 
    latitude = "43.53";
    longitude = "1.46";
    temperature = {
      day = 5500;
      night = 3500;
    };
  };
}
