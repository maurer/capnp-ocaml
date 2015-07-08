{stdenv, buildOcaml, camlp4, core, uint, ocplib-endian, res, omake, findlib,
 pa_ounit, pa_test}:
 
buildOcaml rec {
  name = "capnp";
  version = "2.0.1";
  src = ./.;

  createFindlibDestdir = true;

  buildInputs = [ camlp4 core uint ocplib-endian res omake pa_ounit pa_test ];

  envVars = "OCAML_TOPLEVEL_PATH=${findlib}/lib/ocaml/$ocaml_version/site-lib PREFIX=$out";

  buildPhase = "${envVars} omake";

  installPhase = "${envVars} omake install";

  meta = with stdenv.lib; {
    description = "OCaml Code Generator for Cap'n Proto";
    homepage = https://github.com/pelzlpj/capnp-ocaml;
    license = licenses.bsd2;
  };
}
