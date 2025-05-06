
{ config, pkgs, ... }:
{
  home.file.".config/cargo/config.toml".text = ''
    [build]
    rustflags = ["-Z", "threads=8", "-C", "link-arg=-fuse-ld=mold"]
  '';
}
