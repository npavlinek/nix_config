{ pkgs, ... }:

{
  home.shellAliases = {
    em = "emacs &";
    ls = "ls --color -F";
    ll = "ls -l";
  };
}
