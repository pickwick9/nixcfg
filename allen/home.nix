{ config, pkgs, ... }:

{
  home.username = "allen";
  home.homeDirectory = "/home/allen";

  # dotfiles
  home.file = {
    ".config/nvim/init.lua".source = ./apps/nvim/init.lua;
    ".config/VSCodium/User/keybindings.json".source = ./apps/vscodium/keybindings.json;
    ".config/VSCodium/User/settings.json".source = ./apps/vscodium/settings.json;
    ".gitconfig".source = ./apps/git/.gitconfig;
    ".gnupg/gpg-agent.conf".source = ./apps/gpg/gpg-agent.conf;
    ".rtorrent.rc".source = ./apps/rtorrent/.rtorrent.rc;
    ".tmux.conf".source = ./apps/tmux/.tmux.conf;
    ".zsh_profile".source = ./apps/zsh/.zsh_profile;
    ".zshrc".source = ./apps/zsh/.zshrc;
  };

  # packages
  home.packages = with pkgs; [
    keepassxc
    neofetch
    netcat
    ollama
    python3
    rtorrent
    signal-desktop
    spotdl
    vlc
    vscodium
    yt-dlp
  ];

  # let home manager install and manage itself.
  programs.home-manager.enable = true;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Did you read the comment?
}
