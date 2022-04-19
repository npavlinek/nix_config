{ pkgs, ... }:

{
  programs.urxvt = {
    enable = true;
    package = pkgs.rxvt-unicode;
    extraConfig = {
      color0 = "#1d2021";
      color1 = "#cc241d";
      color2 = "#98971a";
      color3 = "#d79921";
      color4 = "#458588";
      color5 = "#b16286";
      color6 = "#689d6a";
      color7 = "#a89984";
      color8 = "#928374";
      color9 = "#fb4934";
      color10 = "#b8bb26";
      color11 = "#fabd2f";
      color12 = "#83a598";
      color13 = "#d3869b";
      color14 = "#8ec07c";
      color15 = "#ebdbb2";

      background = "#1d2021";
      cursorColor = "#ebdbb2";
      foreground = "#ebdbb2";
    };
    fonts = [ "xft:DejaVu Sans Mono:size=9" ];
    scroll.bar.enable = false;
  };
}
