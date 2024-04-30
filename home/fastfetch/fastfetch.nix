{ config, libs, ... }:
{
  home.file.".config/fastfetch/config.jsonc".text = ''
    	{
        "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
        "modules": [
            "title",
            "separator",
            {
                "type": "os",
                "format": "{3} {12}"
            },
            {
                "type": "host",
                "format": "{/2}{-}{/}{2}{?3} {3}{?}"
            },
            "kernel",
            "uptime",
            "packages",
            "shell",
            {
                "type": "display",
                "compactType": "original",
                "key": "Resolution"
            },
            "de",
            "wm",
            "wmtheme",
            {
                "type": "theme",
                "format": "{?1}{1}{?3} {3}{?} [Plasma], {?}{7}"
            },
            "icons",
            "terminal",
            {
                "type": "terminalfont",
                "format": "{/2}{-}{/}{2}{?3} {3}{?}"
            },
            "cpu",
            {
                "type": "gpu",
                "key": "GPU"
            },
            {
                "type": "memory",
                "format": "{/1}{-}{/}{/2}{-}{/}{} / {}"
            },
            "break",
            "colors"
        	]
    	}	
    	'';
}
