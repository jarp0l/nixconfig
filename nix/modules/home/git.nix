{ config, pkgs, ... }:
let
  userName = "Prajwol Pradhan";
  userEmail = "57973356+jarp0l@users.noreply.github.com";
  allowedSignersFile = "${config.home.homeDirectory}/.ssh/allowed_signers";
  sshPubKeyFile = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
in
{
  home.packages = [ pkgs.git-lfs ];

  # https://nixos.asia/en/git
  programs = {
    git = {
      enable = true;
      package = pkgs.gitAndTools.gitFull;
      userName = "${userName}";
      userEmail = "${userEmail}";
      ignores = [ "*~" "*.swp" ];

      aliases = {
        co = "checkout";
        ci = "commit";
        cia = "commit --amend";
        s = "status";
        st = "status";
        b = "branch";
        # p = "pull --rebase";
        pu = "push";
      };

      delta = {
        enable = true;
        options = {
          features = "decorations";
          navigate = true;
          light = false;
          side-by-side = true;
        };
      };

      iniContent = {
        # Branch with most recent change comes first
        branch.sort = "-committerdate";
        # Remember and auto-resolve merge conflicts
        # https://git-scm.com/book/en/v2/Git-Tools-Rerere
        rerere.enabled = true;
      };

      extraConfig = {
        init.defaultBranch = "main";
        core.editor = "nvim";
        credential.helper = "store --file ${config.home.homeDirectory}/.git-credentials";
        pull.rebase = "false";

        # Sign all commits using ssh key
        commit.gpgsign = true;
        tag.gpgsign = true;
        user.signingkey = "${sshPubKeyFile}";
        gpg = {
          format = "ssh";
          ssh.allowedSignersFile = "${allowedSignersFile}";
        };
      };
    };

    lazygit = {
      enable = true;
      settings = {
        # This looks better with the kitty theme.
        gui.theme = {
          lightTheme = false;
          activeBorderColor = [ "white" "bold" ];
          inactiveBorderColor = [ "white" ];
          selectedLineBgColor = [ "reverse" "white" ];
        };
      };
    };
  };
}
