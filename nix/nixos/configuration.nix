# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./nixvim/nixvim.nix
      ./hardware-configuration.nix
    ];
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-c5b7cd1a-3847-4d8d-b7b3-c8e84bd7360b".device = "/dev/disk/by-uuid/c5b7cd1a-3847-4d8d-b7b3-c8e84bd7360b";
  networking.hostName = "nixos"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "YOURTIMEZONE";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "us";

  # Sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    #jack.enable = true;
    #media-session.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.orperos = {
    isNormalUser = true;
    description = "orperos";
    extraGroups = [ "networkmanager" "wheel" "input" ];
  };
  
  #Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Garbage Collector
  nix.gc = {
	automatic = true;
	dates = "weekly";
	options = "--delete-older-than 30d";
  };
 

  # xorg
  services.xserver.windowManager.qtile = { 
	enable = true;
	extraPackages = python3Packages: with python3Packages; [
		qtile-extras
	];
  
  };
  services.libinput.enable = true;
  services.xserver.enable = true;
  services.displayManager = { 
	sddm.enable = true;
  }; 
  
  # System Packages
  nixpkgs.config.allowUnfree = true;
  programs.zsh.enable = true;
  users.users.orperos.shell = pkgs.zsh;
  environment.systemPackages = with pkgs; [
  rofi  
  git
	wget
	curl
	htop
	alsa-utils
	discord
	osu-lazer-bin
  home-manager
  ];
  fonts.packages = with pkgs; [
    jetbrains-mono
    noto-fonts
    noto-fonts-emoji
    twemoji-color-font
    font-awesome
    powerline-fonts
    powerline-symbols
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
  ];

  system.stateVersion = "24.05"; # Don't change it

}
