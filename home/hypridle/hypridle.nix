{ config, libs, ... }:
{
  home.file.".config/hypr/hypridle.conf".text = ''
    		general {
        		lock_cmd = swaylock
        		ignore_dbus_inhibit = false
    		}
    		listener {
        		timeout = 500
    		}
    	'';
}
