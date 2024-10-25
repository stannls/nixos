{ lib, stdenv, fetchurl, unzip, jdk8, batik, makeWrapper, jre8 }:

stdenv.mkDerivation rec {
  pname = "jflap";
  version = "7.0";

  src = fetchurl {
    url = "http://www.cs.duke.edu/csed/jflap/jflaptmp/july27-18/JFLAP7.1_With_Source.jar";
    sha256 = "sha256-cA0ySrHv6fv8xx2nC2P/UswUjV+gyRpuydaB0HQe+rM=";
  };
  icon = fetchurl {
    url = "https://www.jflap.org/jflapLogo2.jpg";
    sha256 = "sha256-IiworHI+GT6Fm6B0E+FXnKe+hN8nZYPrxHGZFAcsWDw=";
  };

  nativeBuildInputs = [ unzip jdk8 batik makeWrapper ];
  buildInputs = [ batik jre8 ];

  unpackPhase = ''
    		unzip ${src}
    	'';

  patchPhase = ''
    		substituteInPlace "Makefile" --replace 'javac' 'javac -encoding UTF-8'
    		substituteInPlace "Makefile" --replace 'JFLAP.class' 'META-INF'
    		substituteInPlace "mainFile" --replace 'JFLAP' 'gui.Main'
    		substituteInPlace "gui/action/ExportAction.java" --replace 'org.apache.batik.dom.svg.SVGDOMImplementation' 'org.apache.batik.anim.dom.SVGDOMImplementation'
    	'';

  configurePhase = ''
    		make clean
    	'';

  installPhase = ''
    		runHook preInstall
    		install -m755 -D JFLAP.jar $out/share/java/JFLAP.jar
    		install -m755 -D ${icon} $out/share/icons/jflap.jpg

    		echo "[Desktop Entry]
    Name=JFLAP
    Comment=JFLAP is a package of graphical tools which can be used as an aid in learning the basic concepts of Formal Languages and Automata Theory.
    Exec=jflap
    Terminal=false
    Type=Application
    Icon=jflap" > jflap.desktop

    		install -m755 -D jflap.desktop $out/share/applications/jflap.desktop

    		makeWrapper ${jre8}/bin/java $out/bin/jflap \
    			--add-flags "-jar $out/share/java/JFLAP.jar" \
    			--set _JAVA_OPTIONS '-Dawt.useSystemAAFontSettings=on' \
        		--set _JAVA_AWT_WM_NONREPARENTING 1
    	'';

  meta = with lib; {
    description = "Java finite automata simulation";
    homepage = "jflap.org";
    license = licenses.mit;
    platforms = platforms.unix;
  };
}
