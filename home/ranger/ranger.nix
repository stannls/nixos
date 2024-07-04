{ config, libs, ... }:
{
  home.file.".config/ranger/rc.conf".text = ''
      		set preview_images true
    		set preview_images_method ueberzug
  '';
  home.file.".config/ranger/scope.sh".source = ./scope.sh;
}
