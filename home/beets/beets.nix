{ config, pkgs, ... }:
{
	programs.beets.enable = true;	
	programs.beets.settings = {
		directory = ~/Music/Library;
		library = ~/Music/musiclibrary.db;
		import.move = yes;
		chroma.auto = yes;
	};
}
