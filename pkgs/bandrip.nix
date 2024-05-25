{ lib, rustPlatform, fetchFromGitHub, pkgs }:
rustPlatform.buildRustPackage rec {
  pname = "bandrip";
  version = "0.2.2";

  src = fetchFromGitHub {
    owner = "stannls";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-JRbXZcsSLeC4JxDz4v89lKd+cusC5YsL14A8TgYs39k=";
  };

  cargoSha256 = "sha256-Lt1TyJOuFkFKgweQm58MYlzexBTrtsOMtCbuIGsCdf4";

  nativeBuildInputs = with pkgs; [
    pkg-config
  ];

  buildInputs = with pkgs; [
    openssl
  ];

  meta = with lib; {
    description = "A Bandcamp audio ripper.";
    homepage = "https://github.com/stannls/bandrip";
    license = licenses.gpl3;
    maintainers = with maintainers; [ stannls ];
    mainProgram = "bandrip";
  };
}
