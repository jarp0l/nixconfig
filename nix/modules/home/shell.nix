{ ... }:
{
  # Aliases
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

  programs = {
    # on macOS, you probably don't need this
    bash = {
      enable = true;
      initExtra = ''
        # Make Nix and home-manager installed things available in PATH.
        export PATH=/run/current-system/sw/bin/:/nix/var/nix/profiles/default/bin:$HOME/.nix-profile/bin:/etc/profiles/per-user/$USER/bin:$PATH
      '';
    };

    zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      # Directory where the zsh configuration and more should be located, relative to the users home directory.
      dotDir = ".config/zsh";

      history = {
        extended = true;
        ignoreAllDups = true;
      };

      envExtra = ''
        	# Make Nix and home-manager installed things available in PATH.
          export PATH=/run/current-system/sw/bin/:/nix/var/nix/profiles/default/bin:$HOME/.nix-profile/bin:/etc/profiles/per-user/$USER/bin:$PATH
        	
        	export PATH=$HOME/.local/bin:$PATH

        	# For Go
        	GOBIN=$HOME/go/bin
        	export PATH=$GOBIN:$PATH
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

    starship = {
      enable = true;
      # settings = {
      #   username = {
      #     style_user = "blue bold";
      #     style_root = "red bold";
      #     format = "[$user]($style) ";
      #     disabled = false;
      #     show_always = true;
      #   };
      #   hostname = {
      #     ssh_only = false;
      #     ssh_symbol = "🌐 ";
      #     format = "on [$hostname](bold red) ";
      #     trim_at = ".local";
      #     disabled = false;
      #   };
      # };
      settings = {
        aws = {
          format = "\\[[$symbol($profile)(\\($region\\))([$duration])]($style)\\]";
        };

        bun = {
          format = "\\[[$symbol($version)]($style)\\]";
        };

        c = {
          format = "\\[[$symbol($version(-$name))]($style)\\]";
        };

        cmake = {
          format = "\\[[$symbol($version)]($style)\\]";
        };

        cmd_duration = {
          format = "\\[[⏱ $duration]($style)\\]";
        };

        cobol = {
          format = "\\[[$symbol($version)]($style)\\]";
        };

        conda = {
          format = "\\[[$symbol$environment]($style)\\]";
        };

        crystal = {
          format = "\\[[$symbol($version)]($style)\\]";
        };

        daml = {
          format = "\\[[$symbol($version)]($style)\\]";
        };

        dart = {
          format = "\\[[$symbol($version)]($style)\\]";
        };

        deno = {
          format = "\\[[$symbol($version)]($style)\\]";
        };

        docker_context = {
          format = "\\[[$symbol$context]($style)\\]";
        };

        dotnet = {
          format = "\\[[$symbol($version)(🎯 $tfm)]($style)\\]";
        };

        elixir = {
          format = "\\[[$symbol($version \\(OTP $otp_version\\))]($style)\\]";
        };

        elm = {
          format = "\\[[$symbol($version)]($style)\\]";
        };

        erlang = {
          format = "\\[[$symbol($version)]($style)\\]";
        };

        fennel = {
          format = "\\[[$symbol($version)]($style)\\]";
        };

        fossil_branch = {
          format = "\\[[$symbol$branch]($style)\\]";
        };

        gcloud = {
          format = "\\[[$symbol$account(@$domain)(\\($region\\))]($style)\\]";
        };

        git_branch = {
          format = "\\[[$symbol$branch]($style)\\]";
        };

        git_status = {
          format = "([\\[$all_status$ahead_behind\\]]($style))";
        };

        golang = {
          format = "\\[[$symbol($version)]($style)\\]";
        };

        gradle = {
          format = "\\[[$symbol($version)]($style)\\]";
        };

        guix_shell = {
          format = "\\[[$symbol]($style)\\]";
        };

        haskell = {
          format = "\\[[$symbol($version)]($style)\\]";
        };

        haxe = {
          format = "\\[[$symbol($version)]($style)\\]";
        };

        helm = {
          format = "\\[[$symbol($version)]($style)\\]";
        };

        hg_branch = {
          format = "\\[[$symbol$branch]($style)\\]";
        };

        java = {
          format = "\\[[$symbol($version)]($style)\\]";
        };

        julia = {
          format = "\\[[$symbol($version)]($style)\\]";
        };

        kotlin = {
          format = "\\[[$symbol($version)]($style)\\]";
        };

        kubernetes = {
          format = "\\[[$symbol$context( \\($namespace\\))]($style)\\]";
        };

        lua = {
          format = "\\[[$symbol($version)]($style)\\]";
        };

        memory_usage = {
          format = "\\[$symbol[$ram( | $swap)]($style)\\]";
        };

        meson = {
          format = "\\[[$symbol$project]($style)\\]";
        };

        nim = {
          format = "\\[[$symbol($version)]($style)\\]";
        };

        nix_shell = {
          format = "\\[[$symbol$state( \\($name\\))]($style)\\]";
        };

        nodejs = {
          format = "\\[[$symbol($version)]($style)\\]";
        };

        ocaml = {
          format = "\\[[$symbol($version)(\\($switch_indicator$switch_name\\))]($style)\\]";
        };

        opa = {
          format = "\\[[$symbol($version)]($style)\\]";
        };

        openstack = {
          format = "\\[[$symbol$cloud(\\($project\\))]($style)\\]";
        };

        os = {
          format = "\\[[$symbol]($style)\\]";
        };

        package = {
          format = "\\[[$symbol$version]($style)\\]";
        };

        perl = {
          format = "\\[[$symbol($version)]($style)\\]";
        };

        php = {
          format = "\\[[$symbol($version)]($style)\\]";
        };

        pijul_channel = {
          format = "\\[[$symbol$channel]($style)\\]";
        };

        pulumi = {
          format = "\\[[$symbol$stack]($style)\\]";
        };

        purescript = {
          format = "\\[[$symbol($version)]($style)\\]";
        };

        python = {
          format = "\\[[$symbol($pyenv_prefix)($version)(\\($virtualenv\\))]($style)\\]";
        };

        raku = {
          format = "\\[[$symbol($version-$vm_version)]($style)\\]";
        };

        red = {
          format = "\\[[$symbol($version)]($style)\\]";
        };

        ruby = {
          format = "\\[[$symbol($version)]($style)\\]";
        };

        rust = {
          format = "\\[[$symbol($version)]($style)\\]";
        };

        scala = {
          format = "\\[[$symbol($version)]($style)\\]";
        };

        spack = {
          format = "\\[[$symbol$environment]($style)\\]";
        };

        sudo = {
          format = "\\[[as $symbol]($style)\\]";
        };

        swift = {
          format = "\\[[$symbol($version)]($style)\\]";
        };

        terraform = {
          format = "\\[[$symbol$workspace]($style)\\]";
        };

        time = {
          format = "\\[[$time]($style)\\]";
        };

        username = {
          format = "\\[[$user]($style)\\]";
        };

        vagrant = {
          format = "\\[[$symbol($version)]($style)\\]";
        };

        vlang = {
          format = "\\[[$symbol($version)]($style)\\]";
        };

        zig = {
          format = "\\[[$symbol($version)]($style)\\]";
        };

        solidity = {
          format = "\\[[$symbol($version)]($style)\\]";
        };
      };
    };
  };
}
