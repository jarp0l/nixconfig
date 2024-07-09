{ flake, pkgs, ... }:
{
  imports = [
    ./nix-index.nix
    ./neovim.nix # Uncomment this if you do not want to setup Neovim.
    # ./git.nix
    # ./kitty.nix
  ];

  # Recommended Nix settings
  nix = {
    registry.nixpkgs.flake = flake.inputs.nixpkgs; # https://yusef.napora.org/blog/pinning-nixpkgs-flake/

    # FIXME: Waiting for this to be merged:
    # https://github.com/nix-community/home-manager/pull/4031
    # nixPath = [ "nixpkgs=${flake.inputs.nixpkgs}" ]; # Enables use of `nix-shell -p ...` etc

    # Garbage collect the Nix store
    gc = {
      automatic = true;
      # Change how often the garbage collector runs (default: weekly)
      # frequency = "monthly";
    };
  };

  # Nix packages to install to $HOME
  #
  # Search for packages here: https://search.nixos.org/packages
  home.packages = with pkgs; [
    # Unix tools
    ripgrep # Better `grep`
    fd
    sd
    tree
    eza
    dnsutils # for tools e.g. dig
    wget
    netcat-gnu

    # Nix dev
    cachix
    nil # Nix language server
    nix-info
    nixpkgs-fmt
    nixci
    nix-health
    devenv

    # Dev
    tmate

    # On ubuntu, we need this less for `man home-configuration.nix`'s pager to
    # work.
    less

    qutebrowser-qt5
    freetube
    go
    localsend
    infisical
    snyk
    d2
    awscli2
    opentofu

    # for utils such as lsusb
    usbutils

    wl-clipboard
    flameshot

    # osquery
  ];

  home.shellAliases = {
    g = "git";
    lg = "lazygit";
    v = "nvim";
    ".." = "cd ..";
    ls = "eza --grid --color auto --icons --sort=type";
    ll = "eza --long --color always --icons --sort=type";
    la = "eza --grid --all --color auto --icons --sort=type";
    lla = "eza --long --all --color auto --icons --sort=type";
    l = "lla";
    python = "python3";
    py = "python3";
  };

  # Programs natively supported by home-manager.
  programs = {
    bash = {
      enable = true;
      initExtra = ''
        # Make Nix and home-manager installed things available in PATH.
        export PATH=/run/current-system/sw/bin/:/nix/var/nix/profiles/default/bin:$HOME/.nix-profile/bin:/etc/profiles/per-user/$USER/bin:$PATH
      '';
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      # Directory where the zsh configuration and more should be located, relative to the users home directory.
      dotDir = ".config/zsh";

      history = {
        extended = true;
        ignoreAllDups = true;
      };

      envExtra = ''
        export PATH=$HOME/.local/bin:$PATH
        # Make Nix and home-manager installed things available in PATH.
        export PATH=/run/current-system/sw/bin/:/nix/var/nix/profiles/default/bin:$HOME/.nix-profile/bin:/etc/profiles/per-user/$USER/bin:$PATH
      '';

      initExtra = ''
        function mkcd () {
          mkdir -p "$*"
          cd "$*"
        }

        # https://nixos.wiki/wiki/Zsh#Zsh-autocomplete_not_working
        # bindkey "''${key[Up]}" up-line-or-search
      '';

      sessionVariables = rec {
        EDITOR = "nvim";
        VISUAL = EDITOR;
        GIT_EDITOR = EDITOR;
        GOPATH = "$HOME/go";
        GOBIN = "$HOME/go/bin";
      };

      prezto = {
        enable = true;
        caseSensitive = false;
        editor.dotExpansion = true;
        editor.keymap = "vi";
        # python.virtualenvAutoSwitch = true;
      };

      #      plugins = [
      #        {
      #          name = "zsh-autocomplete";
      #          src = pkgs.fetchFromGitHub {
      #            owner = "marlonrichert";
      #            repo = "zsh-autocomplete";
      #            rev = "23.07.13";
      #            sha256 = "0NW0TI//qFpUA2Hdx6NaYdQIIUpRSd0Y4NhwBbdssCs=";
      #          };
      #        }
      #        {
      #          name = "zsh-nix-shell";
      #          file = "nix-shell.plugin.zsh";
      #          src = pkgs.fetchFromGitHub {
      #            owner = "chisui";
      #            repo = "zsh-nix-shell";
      #            rev = "v0.8.0";
      #            sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
      #          };
      #        }
      #      ];
    };

    # Better `cd`
    bat.enable = true;
    # Type `z <pat>` to cd to some directory
    zoxide.enable = true;
    # Type `<ctrl> + r` to fuzzy search your shell history
    fzf.enable = true;
    fzf.enableZshIntegration = true;
    jq.enable = true;
    htop.enable = true;

    starship = {
      enable = true;
    };

    # https://nixos.asia/en/direnv
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    vscode = {
      enable = true;
      package = pkgs.vscodium;
      extensions = with pkgs.vscode-extensions; [
        catppuccin.catppuccin-vsc
        eamodio.gitlens
        pkief.material-icon-theme
        yzhang.markdown-all-in-one
      ];
    };
  };
}
