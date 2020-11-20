{ stdenv, fetchurl, xorg, libGL, libGLU, tetgen, imagemagick, psutils, gnuplot, ghostscript }:

stdenv.mkDerivation rec {
  pname = "cgx";
  version = "2.17.1";

  src = fetchurl {
    url = "http://www.dhondt.de/cgx_${version}.all.tar.bz2";
    sha256 = "3fcd2ec59fd65e3b51cacf4c6ace21bf36570ea4527ba9840e52c96736c4dc0f";
  };

  doCheck = false;

  enableParallelBuilding = true;

  buildInputs = [ libGL libGLU xorg.libX11 xorg.libXmu xorg.libXext xorg.libXi ];

  sourceRoot = "CalculiX/cgx_${version}/src";

  NIX_CFLAGS_COMPILE = toString [
    "-O2 -w"
    ];

  installPhase = ''
#    install -Dm0755 cgx $out/bin/cgx
    install -D cgx $out/bin/cgx
  '';

  meta = with stdenv.lib; {
    homepage = "http://www.dhonth.de/";
    description = "Three-dimensional structural finite element program viewer";
    license = licenses.gpl2Plus;
    maintainers = with maintainers; [ "bonomo" ];
    platforms = platforms.unix;
  };
}

