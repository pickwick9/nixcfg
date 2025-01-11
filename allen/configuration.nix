{ config, pkgs, pkgs-2405, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  nixpkgs.config.allowUnfree = true;

  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ]; 
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  environment.systemPackages = (with pkgs; [
    direnv
    docker
    fzf
    git
    gnupg
    htop
    lsof
    neovim
    pinentry
    tmux
    tree
    wget
    wl-clipboard
    zsh
  ]) ++ (with pkgs-2405; [
    # ...
  ]);

  users.users.allen = {
    isNormalUser = true;
    description = "allen";
    extraGroups = [ "docker" "networkmanager" "wheel" ];
    packages = (with pkgs; [
      android-studio
      awscli
      dnsutils
      gimp
      kdePackages.kdenlive
      keepassxc
      kicad
      magic-vlsi
      neofetch
      netcat
      ngspice
      nmap
      popsicle
      python3
      qbittorrent
      signal-desktop
      spotdl
      tealdeer
      texliveFull
      tshark
      ungoogled-chromium
      vlc
      vscodium
      xournalpp
      xschem
      yt-dlp
    ]) ++ (with pkgs-2405; [
      # ...
    ]);
  };

  programs = {
    firefox.enable = true;
    zsh = {
      enable = true;
      ohMyZsh.enable = true;
    };
  };

  users.defaultUserShell = pkgs.zsh;

  virtualisation.docker.enable = true;

  services = {
    printing.enable = true; # enable CUPS to print documents.
    xserver = {
      desktopManager.plasma6.enable = true;
      displayManager.sddm.enable = true;
      enable = true;
      layout = "us";
      xkbVariant = "";
    };
  };

  networking = {
    firewall = {
      enable = true;
      # allow incoming TCP connections for certain services (expo, supabase)
      extraCommands = ''
        # expo
        iptables --check nixos-fw --protocol tcp --dport 8081 --source 192.168.1.159/24 --jump ACCEPT || iptables --insert nixos-fw --protocol tcp --dport 8081 --source 192.168.1.159/24 --jump ACCEPT;
        # supabase
        iptables --check nixos-fw --protocol tcp --dport 54321 --jump ACCEPT || iptables --insert nixos-fw --protocol tcp --dport 54321 --jump ACCEPT;
        iptables --check nixos-fw --protocol tcp --dport 54322 --jump ACCEPT || iptables --insert nixos-fw --protocol tcp --dport 54322 --jump ACCEPT;
        iptables --check nixos-fw --protocol tcp --dport 54323 --jump ACCEPT || iptables --insert nixos-fw --protocol tcp --dport 54323 --jump ACCEPT;
        iptables --check nixos-fw --protocol tcp --dport 54324 --jump ACCEPT || iptables --insert nixos-fw --protocol tcp --dport 54324 --jump ACCEPT;
        iptables --check nixos-fw --protocol tcp --dport 54327 --jump ACCEPT || iptables --insert nixos-fw --protocol tcp --dport 54327 --jump ACCEPT;
      '';
      extraStopCommands = ''
        # expo
        iptables --check nixos-fw --protocol tcp --dport 8081 --source 192.168.1.159/24 --jump ACCEPT && iptables --delete nixos-fw --protocol tcp --dport 8081 --source 192.168.1.159/24 --jump ACCEPT;
        # supabase
        iptables --check nixos-fw --protocol tcp --dport 54321 --jump ACCEPT && iptables --delete nixos-fw --protocol tcp --dport 54321 --jump ACCEPT;
        iptables --check nixos-fw --protocol tcp --dport 54322 --jump ACCEPT && iptables --delete nixos-fw --protocol tcp --dport 54322 --jump ACCEPT;
        iptables --check nixos-fw --protocol tcp --dport 54323 --jump ACCEPT && iptables --delete nixos-fw --protocol tcp --dport 54323 --jump ACCEPT;
        iptables --check nixos-fw --protocol tcp --dport 54324 --jump ACCEPT && iptables --delete nixos-fw --protocol tcp --dport 54324 --jump ACCEPT;
        iptables --check nixos-fw --protocol tcp --dport 54327 --jump ACCEPT && iptables --delete nixos-fw --protocol tcp --dport 54327 --jump ACCEPT;
      '';
    };
    hostName = "nixos";
    networkmanager.enable = true;
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
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
