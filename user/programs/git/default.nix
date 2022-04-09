{ pkgs, ... }:

{
  programs.git = {
    enable = true;

    userName = "Niko Pavlinek";
    userEmail = "niko.pavlinek@gmail.com";

    extraConfig = {
      init = {
        defaultBranch = "master";
      };

      pull = {
        rebase = true;
      };

      rebase = {
        autosquash = true;
      };
    };
  };
}
