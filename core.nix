{ config, pkgs, lib, ... }:

with lib;

{
  system.stateVersion = "18.09";

  # Keep only the last 500MiB of systemd journal
  services.journald.extraConfig = "SystemMaxUse=500M";

  # Collect nix store garbage and optimise daily.
  nix.gc.automatic = true;
  nix.optimise.automatic = true;

  # Enable passwd and co.
  users.mutableUsers = true;

  # Select internationalisation properties.
  i18n = {
    consoleKeyMap = "colemak";
  };

  time.timeZone = "Europe/Paris";

  networking.firewall = {
    allowPing = true;
  };

  services.openssh = {
    enable = true;
    passwordAuthentication = true;
  };

  programs.fish.enable = true;

  users.users.jonlaokan = {
    createHome = true;
    extraGroups = [ "wheel" "networkmanager" ];
    home = "/home/jonlaokan";
    isNormalUser = true;
    shell = pkgs.fish;
    uid = 1000;
  };

  fonts = {
    enableFontDir = true;
    fonts = with pkgs; [
      opensans-ttf
      siji
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs;
  let
    core = [
      # Dev
      gnumake
      gcc8
      ghc
      python37
      jdk10
      maven

      # File manager 
      ranger

      # Text editor & shell
      vim
      neovim
      fish
      python36Packages.neovim

      # Tools
      htop
      man-pages
      neofetch
      nmap
      ponymix
      sox
      stow
      tree
      unzip
      wget
    ];

    noxserver = [];

    xserver = [
      # Browser
      firefox
      qutebrowser

      # Desktop UX
      haskellPackages.xmobar

      # Dev
      android-studio
      jetbrains.idea-ultimate
      netbeans
      vscode

      # File manager
      xfce.thunar
      xfce.thunar-dropbox-plugin
      xfce.thunar-volman
      xfce.thunar-archive-plugin

      # Graphics
      gimp
      inkscape

      # Misc
      dunst
      zathura
      anki
      redshift

      # Services
      dropbox

      # Theming
      (lxappearance.overrideAttrs(old:
      rec {
        name = "lxappearance-0.6.2";
        src = fetchurl {
          url = "mirror://sourceforge/project/lxde/LXAppearance/${name}.tar.xz";
          sha256 = "07r0xbi6504zjnbpan7zrn7gi4j0kbsqqfpj8v2x94gr05p16qj4";
        };
      }))

      # Tools
      compton
      feh
      imagemagick7
      maim 
      mpv
      rofi
      termite
      xclip
      xdotool
      xorg.xbacklight
      zip
    ];

  in core ++ (if config.services.xserver.enable then xserver else noxserver);
}
