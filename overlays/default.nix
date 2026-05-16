{ inputs, ... }: {
  additions = final: _prev: import ../pkgs final.pkgs;
  modifications = final: prev: { 
    openldap = prev.openldap.overrideAttrs (old: {
      doCheck = ! final.stdenv.hostPlatform.isi686;
    });
  };
}
