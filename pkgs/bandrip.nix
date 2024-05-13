{ lib, rustPlatform, fetchFromGitHub }:
rustPlatform.buildRustPackage rec {
  pname = "bandrip";
  version = "0.2.2";

  src = fetchFromGitHub {
    owner = "stannls";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-6caa360626012e106c970a142bf21381d87397411a3b5c1a5c52736c3b66d59e";
  };

  cargoSha256 = "sha256-yIwCBm46sgrpTt45uCyyS7M6V0ReGUXVu7tyrjdNqeQ=";

  meta = with lib; {
    description = "A Bandcamp audio ripper.";
    homepage = "https://github.com/stannls/bandrip";
    license = licenses.gpl3;
    maintainers = with maintainers; [ stannls ];
    mainProgram = "bandrip";
  };
}
