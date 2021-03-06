{ stdenv, fetchurl, ocaml, findlib }:

if stdenv.lib.versionOlder ocaml.version "4.07"
then throw "dune is not available for OCaml ${ocaml.version}"
else

stdenv.mkDerivation rec {
  pname = "dune";
  version = "2.5.0";

  src = fetchurl {
    url = "https://github.com/ocaml/dune/releases/download/${version}/dune-${version}.tbz";
    sha256 = "1nnpg0fvmp4vf5mk203xk83pkkm953pgip3yhs1x2g8pkcdndhcw";
  };

  buildInputs = [ ocaml findlib ];

  buildFlags = "release";

  dontAddPrefix = true;

  installFlags = [ "PREFIX=${placeholder "out"}" "LIBDIR=$(OCAMLFIND_DESTDIR)" ];

  meta = {
    homepage = "https://dune.build/";
    description = "A composable build system";
    changelog = "https://github.com/ocaml/dune/releases/tag/${version}";
    maintainers = [ stdenv.lib.maintainers.vbgl stdenv.lib.maintainers.marsam ];
    license = stdenv.lib.licenses.mit;
    inherit (ocaml.meta) platforms;
  };
}
