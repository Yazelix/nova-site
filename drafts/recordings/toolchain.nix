{
  system ? builtins.currentSystem,
}:
let
  nixpkgsRev = "e9a7635a57597d9754eccebdfc7045e6c8600e6b";
  pkgs = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/${nixpkgsRev}.tar.gz";
    sha256 = "sha256-u6WU/yd/o8iYQrHX3RAwO1hYa3LkoSL+WNQD0rJfJZQ=";
  }) { inherit system; };
in
pkgs.buildEnv {
  name = "nova-site-recording-toolchain";
  paths = [
    pkgs.bash
    pkgs.coreutils
    pkgs.ffmpeg-full
    pkgs.git
    pkgs.jq
    pkgs.gnused
    pkgs.picom
    pkgs.xdotool
    pkgs.xorg-server
    pkgs.xwallpaper
    pkgs.zoxide
    (pkgs.writeShellScriptBin "record-nova-demo" ''
      exec ${pkgs.bash}/bin/bash "$PWD/drafts/recordings/record.sh" "$@"
    '')
  ];
}
