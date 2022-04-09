{ pkgs, ... }:

let
  np-vim-apl = pkgs.vimUtils.buildVimPlugin {
    name = "vim-apl";
    src = pkgs.fetchFromGitHub {
      owner = "PyGamer0";
      repo = "vim-apl";
      rev = "f05c544b34a731d00105f30a28a0a94d935341d8";
      hash = "sha256-CDUQ3YNX5aFVpYFk+ND3bAFK36fiFVcfCyQFTrR2t3w=";
    };
  };
in {
  programs.vim = {
    enable = true;
    extraConfig = builtins.readFile ./vimrc;
    plugins = with pkgs.vimPlugins; [
      gruvbox-community
      np-vim-apl
    ];
  };

  home.file.".vim" = {
    source = ./vimfiles;
    recursive = true;
  };
}
