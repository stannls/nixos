{ pkgs, config, ... }:

let
  palette = config.colorScheme.palette;
in
{
  home.file.".config/rofi/config.rasi".text = ''
    @theme "/dev/null"

    * {
      bg: #${palette.base00};
      background-color: @bg;
    }

    configuration {
      modi:		    "ssh,run,drun";
      show-icons:	    true;
      icon-theme:	    "Papirus";
      location:		    0;
      font:		    "JetBrainsMono Nerd Font 16";	
      terminal:             "alacritty";
      drun-display-format:  "{icon} {name}";
      display-drun:	    "   Apps ";
      display-run:          "  Run ";
      display-ssh:          "  SSH ";
    }

    window { 
      x-offset: 10px;
      y-offset: 10px;
      location: center;

      width: 450px;
      transparency: "real";
      orientation: vertical;
      border: 2px ;
      border-color: #${palette.base0E};
      border-radius: 15px;
    }

    mainbox {
      children: [ inputbar, listview, mode-switcher ];
    }

    // ELEMENT
    // -----------------------------------

    element {
      padding: 8 14;
      text-color: #${palette.base05};
      border-radius: 5px;
    }

    element selected {
      text-color: #${palette.base01};
      background-color: #${palette.base0C};
    }

    element-text {
      background-color: inherit;
      text-color: inherit;
    }

    element-icon {
      size: 24 px;
      background-color: inherit;
      padding: 0 6 0 0;
      alignment: vertical;
    }

    listview {
      columns: 1;
      padding: 8 0;
      fixed-height: true;
      fixed-columns: true;
      fixed-lines: true;
      border: 0 10 6 10;
    }

    // INPUT BAR 
    //------------------------------------------------

    entry {
      placeholder: "Start typing here!";
      placeholder-color: #${palette.base01};
      text-color: #${palette.base05};
      padding: 10 10 0 0;
      margin: 0 -2 0 0;
    }

    inputbar {
      background-image: url("~/.config/rofi/rofi.jpg", width);
      padding: 0 0 0;
      margin: 0 0 0 0;
    } 

    prompt {
      text-color: #${palette.base0D};
      padding: 10 6 0 10;
      margin: 0 -2 0 0;
    }

    // Mode Switcher
    //------------------------------------------------

    mode-switcher {
      border-color:   #${palette.base0F};
      spacing:	      0;
    }

    button {
      padding:	      10px;
      background-color: @bg;
      text-color: #${palette.base01};
      vertical-align:   0.5; 
      horizontal-align: 0.5;
    }

    button selected {
      background-color: @bg;
      text-color: #${palette.base0E};
    }

    message {
      background-color: @bg;
      margin: 2px;
      padding: 2px;
      border-radius: 5px;
    }

    textbox {
      padding: 6px;
      margin: 20px 0px 0px 20px;
      text-color: #${palette.base0F};
      background-color: @bg;
    }
  '';
}
