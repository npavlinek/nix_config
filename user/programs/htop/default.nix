{ pkgs, ... }:

{
  programs.htop = {
    enable = true;
    settings = {
      color_scheme = 6;
      highlight_base_name = true;
      highlight_megabytes = true;
      highlight_threads = true;
      show_cpu_frequency = true;
      show_cpu_usage = true;
    };
  };
}
