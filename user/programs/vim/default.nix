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
  np-hlsl = pkgs.vimUtils.buildVimPlugin {
    name = "hlsl.vim";
    src = pkgs.fetchFromGitHub {
      owner = "beyondmarc";
      repo = "hlsl.vim";
      rev = "0b4c07454afabee0b9ab63ba4c53e43a47e25724";
      hash = "sha256-5L1MHodtnpQ8YbsdPneZyv9UqjcHOT2pEPhXqKeJUvw=";
    };
  };
in {
  programs.vim = {
    enable = true;
    extraConfig = builtins.readFile ./vimrc;
    plugins = with pkgs.vimPlugins; [
      np-hlsl
      np-vim-apl
      vim-gruvbox8
    ];
  };

  home.file.".vim" = {
    source = ./vimfiles;
    recursive = true;
  };
}
