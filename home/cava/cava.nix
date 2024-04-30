{ config, libs, ... }:
{
  programs.cava.enable = true;
  programs.cava.settings = {
    general.framerate = 100;
    color = {
      gradient = 1;
      gradient_count = 8;
      gradient_color_1 = "#9967c4";
      gradient_color_2 = "#9967c4";
      gradient_color_3 = "#7aa2f7";
      gradient_color_4 = "#7aa2f7";
      gradient_color_5 = "#f7768e";
      gradient_color_6 = "#f7768e";
      gradient_color_7 = "#f7768e";
      gradient_color_8 = "#f7768e";

    };
  };
}
