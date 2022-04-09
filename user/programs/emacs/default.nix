{ pkgs, ... }:

{
  programs.emacs = {
    enable = false;
    extraPackages = epkgs: [
      epkgs."clang-format+"
      epkgs.cider
      epkgs.cmake-mode
      epkgs.doom-themes
      epkgs.gruvbox-theme
      epkgs.haskell-mode
      epkgs.magit
      epkgs.nix-mode
      epkgs.paredit
      epkgs.use-package
    ];
  };

  home.file.".emacs.d" = {
    source = ./.emacs.d;
    recursive = true;
  };
}
