{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    raylib
    xorg.libX11
    xorg.libXrandr
    xorg.libXinerama
    xorg.libXcursor
    xorg.libXi
    xorg.libXext
    libGL
    libGLU
  ];

  LD_LIBRARY_PATH = "${pkgs.lib.makeLibraryPath [ pkgs.libGL ]}";
}