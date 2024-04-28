{ config, pkgs, ... }:
{
	programs.alacritty.enable = true;	
	programs.alacritty.settings = {
		window = {
			opacity = 0.8;
			class = {
				general = "Alacritty";
				instance = "Alacritty";
			};
		};
		scrolling.history = 5000;

		colors.bright = {
			black = "#484867";
			blue = "#6d6dc9";
			cyan = "#6ab6bd";
			green = "#71ab3a";
			magenta = "#956ad3";
			red = "#e15877";
			white = "#e8e6e9";
			yellow = "#c6a642";
		};

		colors.normal = {
			black = "#111133";
			blue = "#5556d3";
			cyan = "#52afb7";
			green = "#48a842";
			magenta = "#8650d3";
			red = "#d61d52";
			white = "#9f9aa7";
			yellow = "#e1a51c";
		};

		colors.primary = {
			background = "#272537";
			foreground = "#e8e6e9";
		};

		font = {
			size = 12.0;
			glyph_offset = {
				x = 0;
				y = 0;
			};
			offset = {
				x =  0;
				y = 0;
			};
			bold = {
				family = "iosevka";
				style = "Bold";
			};
			bold_italic = {
				family = "iosevka";
				style = "Bold Italic";
			};
			italic = {
				family = "iosevka";
				style = "Italic";
			};
			normal = {
				family = "iosevka";
				style = "Regular";
			};
		};
	};
}
