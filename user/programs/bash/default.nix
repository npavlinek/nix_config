{ pkgs, ... }:

{
  programs.bash = {
    enable = true;

    historyControl = [
      "erasedups"
    ];
    historySize = 10000;

    shellOptions = [
      "histappend"
    ];

    initExtra = builtins.readFile ./config.bash;
  };
}
