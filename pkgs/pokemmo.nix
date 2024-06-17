{ stdenv, lib
, fetchgit
, fetchurl
, wget
, openssl
, jdk21
, autoPatchelfHook
}:

stdenv.mkDerivation rec {
  pname = "pokemmo";
  version = "1.4.8";

  src = fetchgit {
    url = "https://aur.archlinux.org/pokemmo.git";
	rev = "11e906da6ce13532f5cd00e1f67ac9b17c2d9a9b";
    hash = "sha256-8Bd7VWdgFk9mSSVUlPL6b7D2VTJNEzoeU+rrtXVXLKw=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  buildInputs = [
    wget
	openssl
	jdk21
  ];

  sourceRoot = ".";

  installPhase = ''
    runHook preInstall
    install -m755 -D ${src.name}/pokemmo-launcher $out/bin/pokemmo-launcher
	install -m755 -D ${src.name}/pokemmo.desktop $out/share/applications/pokemmo.desktop
	install -m755 -D ${src.name}/pokemmo-launcher.png  $out/share/icons/pokemmo-launcher.png
    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://pokemmo.net";
    description = "Pokemmo";
    platforms = platforms.linux;
  };
}
