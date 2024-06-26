{ config, pkgs, ... }:
{
  services.dunst.enable = true;
  services.dunst.settings = {
    global = {
      monitor = 0;
      follow = "mouse";
      width = 300;
      height = 300;
      origin = "top-right";
      offset = "10x50";
      progress_bar = true;
      progress_bar_height = 10;
      progress_bar_frame_width = 1;
      progress_bar_min_width = 150;
      progress_bar_max_width = 300;
      indicate_hidden = "yes";
      shrink = "no";
      transparency = 15;
      separator_height = 2;
      padding = 8;
      horizontal_padding = 10;
      text_icon_padding = 0;
      frame_width = 1;
      frame_color = "#D3D7CF";
      separator_color = "frame";
      sort = "yes";
      font = "Droid Sans 14";
      line_height = 0;
      markup = "full";
      format = "%a\n<b>%s</b>\n%b";
      alignment = "left";
      vertical_alignment = "center";
      show_age_threshold = 60;
      word_wrap = "yes";
      ellipsize = "middle";
      ignore_newline = "no";
      stack_duplicates = true;
      hide_duplicate_count = false;
      show_indicators = "yes";
      icon_theme = "Dracula";
      enable_recursive_icon_lookup = true;
      icon_position = "left";
      min_icon_size = 64;
      max_icon_size = 128;
      sticky_history = "yes";
      history_length = 20;
      dmenu = "wofi";
      browser = "/usr/bin/xdg-open";
      always_run_script = true;
      title = "Dunst";
      class = "Dunst";
      corner_radius = 0;
      ignore_dbusclose = false;
      force_xwayland = false;
      force_xinerama = false;
      mouse_left_click = "close_current";
      mouse_middle_click = "do_action, close_current";
      mouse_right_click = "context";
    };
    experimental.per_monitor_dpi = true;
    urgency_low = {
      background = "#222222";
      foreground = "#888888";
      timeout = 10;
    };
    urgency_normal = {
      background = "#2b2e37";
      foreground = "#ffffff";
      timeout = 10;
    };
    urgency_critical = {
      background = "#900000";
      foreground = "#ffffff";
      frame_color = "#ff0000";
      timeout = 0;
    };
    firefox-plugin = {
      appname = "Firefox";
      summary = "* Fingerprint *";
      timeout = 2;
      format = "%b";
      urgency = "low";
    };
    grimblast = {
      appname = "grimblast";
      timeout = 2;
      new_icon = "/usr/share/icons/bloom-dark/mimetypes/48/image-png.svg";
    };
  };
}
