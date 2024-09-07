{ pkgs, ... }:
{
  # Nix packages to install to $HOME
  #
  # Search for packages here: https://search.nixos.org/packages
  home.packages = with pkgs; [
    # Nix dev
    cachix
    nil # Nix language server
    nix-info
    nixpkgs-fmt
    omnix
    # Dev
    tmate
    devbox # https://www.jetify.com/devbox/docs/

    # Essential tools
    ripgrep # Better `grep`
    fd
    sd
    tree
    eza
    wget
    less
    usbutils # for utils such as lsusb
    wl-clipboard # clipboard provider for nvim

    # applications
    flameshot
    go
    qutebrowser-qt5
    freetube
    localsend
    infisical
    snyk
    d2
    awscli2
    opentofu
  ];

  # Programs natively supported by home-manager.
  # They can be configured in `programs.*` instead of using home.packages.
  programs = {
    # Better `cat`
    bat.enable = true;
    # Type `<ctrl> + r` to fuzzy search your shell history
    fzf.enable = true;
    jq.enable = true;
    # Install btop https://github.com/aristocratos/btop
    btop.enable = true;
    # Type `z <pat>` to cd to some directory
    zoxide.enable = true;
  };
}
