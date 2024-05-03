{ lib, stdenv, fetchurl, gtk-engine-murrine }:

stdenv.mkDerivation rec {
  pname = "dracula";
  version = "4.0.0";

  srcs = [
    (fetchurl {
      url = "https://github.com/dracula/gtk/releases/download/${version}/Juno-palenight.tar.xz";
      sha256 = "199bd4051b243fddadc625038686c7e8a91d4e8098868aadb4ca4c0c80911b6f";
    })
  ];

  sourceRoot = ".";

  propagatedUserEnvPkgs = [ gtk-engine-murrine ];

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/themes
    cp -a Juno* $out/share/themes
    rm $out/share/themes/*/{LICENSE,README.md}
    runHook postInstall
  '';

  meta = with lib; {
    description = "Dracula GTK theme.";
    homepage = "https://github.com/dracula/gtk";
    license = licenses.gpl3Only;
    platforms = platforms.all;
    maintainers = [ maintainers.stannis ];
  };
}
