{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];


  environment.systemPackages = with pkgs; [
    direnv
    fzf
    git
    gnupg
    htop
    lsof
    neovim
    pinentry
    tmux
    wget
    wl-clipboard
    zsh
  ];


  users = {
    defaultUserShell = pkgs.zsh;
    users.allen = {
      isNormalUser = true;
      description = "allen";
      extraGroups = [ "networkmanager" "wheel" ];
    };
  };


  programs = {
    firefox.enable = true;
    zsh = {
      enable = true;
      ohMyZsh.enable = true;
    };
  };


  services = {
    printing.enable = true; # enable CUPS to print documents.
    ollama = {
      acceleration = "rocm";
      enable = true;
      environmentVariables = {
        HSA_OVERRIDE_GFX_VERSION = "11.0.0";
      };
    };
    xserver = {
      desktopManager.plasma6.enable = true;
      displayManager.sddm.enable = true;
      enable = true;
      layout = "us";
      xkbVariant = "";
    };
  };


  nixpkgs.config.allowUnfree = true;


  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ]; 
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };


  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;


  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };


  networking = {
    firewall = {
      enable = true;
      # allow incoming TCP connections on port 8081 from 192.168.1.159/24 (for expo)
      extraCommands = ''
        iptables --check nixos-fw --protocol tcp --dport 8081 --source 192.168.1.159/24 --jump ACCEPT || \
        iptables --insert nixos-fw --protocol tcp --dport 8081 --source 192.168.1.159/24 --jump ACCEPT;
      '';
      extraStopCommands = ''
        iptables --check nixos-fw --protocol tcp --dport 8081 --source 192.168.1.159/24 --jump ACCEPT && \
        iptables --delete nixos-fw --protocol tcp --dport 8081 --source 192.168.1.159/24 --jump ACCEPT;
      '';
    };
    hostName = "nixos";
    networkmanager.enable = true;
  };


  time.timeZone = "America/New_York";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
