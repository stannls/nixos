{ lib, rustPlatform, fetchFromGitHub, pkgs }:
rustPlatform.buildRustPackage rec {
  pname = "nixify";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "stannls";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-WhdSpnRn6hkENswx0URgKjvC2sdotdgWyMUNd9pu/i8=";
  };

  cargoSha256 = "sha256-srhhvMByil2YVj9XZEy4f1HUiax8SEp+VXlaEoVvmIY=";

  nativeBuildInputs = with pkgs; [
    pkg-config
  ];

  buildInputs = with pkgs; [
  ];

  meta = with lib; {
    description = "A Bandcamp audio ripper.";
    homepage = "https://github.com/stannls/bandrip";
    license = licenses.gpl3;
    maintainers = with maintainers; [ stannls ];
    mainProgram = "nixify";
  };
}
