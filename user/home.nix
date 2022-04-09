{ pkgs, ... }:

let
  fontList = with pkgs; [
    anonymousPro
    dejavu_fonts
    iosevka
    liberation_ttf
    source-code-pro
  ];
in {
  home.packages = with pkgs; [
    age
    brightnessctl
    dmenu
    keepassxc
    sops
  ] ++ fontList;

  programs = {
    firefox.enable = true;
    man.generateCaches = true;
  };

  services = {
    syncthing.enable = true;
  };

  imports = [
    ./programs/bash
    ./programs/emacs
    ./programs/git
    ./programs/htop
    ./programs/sh
    ./programs/urxvt
    ./programs/vim
    ./programs/xmobar
    ./programs/xmonad
    ./programs/zathura
  ];
}
