{ lib
, stdenv
, fetchFromGitHub
, python3Packages
, installShellFiles
, procps
, pkgs
, pcsclite
}:

python3Packages.buildPythonPackage rec {
  pname = "yubikey-manager";
  version = "5.4.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "Yubico";
    repo = "yubikey-manager";
    rev = version;
    hash = "sha256-c5edonnvvGIZ6SJ6+gd2xcAy0/HiAEUEPMGQzOKK2Sw=";
  };

  postPatch = ''
    substituteInPlace "ykman/pcsc/__init__.py" \
      --replace 'pkill' '${if stdenv.isLinux then procps else "/usr"}/bin/pkill'
  '';

  postFixup = ''
    wrapProgram $out/bin/ykman \
    --prefix LD_LIBRARY_PATH ":" "/run/current-system/sw/share/nix-ld/lib" \
  '';

  nativeBuildInputs = with python3Packages; [
    poetry-core
    pythonRelaxDepsHook
    installShellFiles
  ];

  propagatedBuildInputs = with python3Packages; [
    cryptography
    pyscard
    fido2
    click
    keyring
	pkgs.pcsclite
  ];

  buildInputs = with pkgs; [
  	pcsclite
  ];

  pythonRelaxDeps = [
    "keyring"
  ];

  postInstall = ''
    installManPage man/ykman.1

    installShellCompletion --cmd ykman \
      --bash <(_YKMAN_COMPLETE=bash_source "$out/bin/ykman") \
      --zsh  <(_YKMAN_COMPLETE=zsh_source  "$out/bin/ykman") \
      --fish <(_YKMAN_COMPLETE=fish_source "$out/bin/ykman") \
  '';

  nativeCheckInputs = with python3Packages; [
    pytestCheckHook
    makefun
  ];

  meta = with lib; {
    homepage = "https://developers.yubico.com/yubikey-manager";
    changelog = "https://github.com/Yubico/yubikey-manager/releases/tag/${version}";
    description = "Command line tool for configuring any YubiKey over all USB transports";

    license = licenses.bsd2;
    platforms = platforms.unix;
    maintainers = with maintainers; [ benley lassulus pinpox nickcao ];
    mainProgram = "ykman";
  };
}
