{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      catppuccin.catppuccin-vsc
      eamodio.gitlens
      pkief.material-icon-theme
      yzhang.markdown-all-in-one
    ];
  };
}
