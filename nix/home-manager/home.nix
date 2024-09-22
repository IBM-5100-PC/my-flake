
{ config, pkgs, ... }: {

  imports = [
    ./zsh.nix
  ];

  home = {
		username = "orperos";
		homeDirectory = "/home/orperos";
		stateVersion = "24.05";
		packages = with pkgs; [
      onefetch
      appimage-run
			tree
			obs-studio
			nitch
			floorp
			pavucontrol
			nitrogen	
			picom
			fastfetch
			oksh
			kitty
			nextcloud-client
			yazi 
			flameshot
			vim
			tmux
			nsxiv
			mpv
		];
	};

}

