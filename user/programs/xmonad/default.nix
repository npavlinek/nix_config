{ pkgs, ... }:

let
  xsetExe = "${pkgs.xorg.xset}/bin/xset";
  xsetrootExe = "${pkgs.xorg.xsetroot}/bin/xsetroot";
  xrdbExe = "${pkgs.xorg.xrdb}/bin/xrdb";
  xmonadExe = "${pkgs.haskellPackages.xmonad}/bin/xmonad";
in {
  home.file.".xinitrc".text = ''
    # Turn off display after 5 minutes.
    ${xsetExe} s 300

    # Increate key-repeat rate.
    ${xsetExe} r rate 300 50

    # Set the cursor theme.
    ${xsetrootExe} -cursor_name left_ptr

    ${xrdbExe} -merge $HOME/.Xresources

    exec ${xmonadExe}
  '';

  xsession.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
    config = ./xmonad.hs;
  };
}
