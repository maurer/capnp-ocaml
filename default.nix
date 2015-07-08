{ nixpkgs ? import <nixpkgs> {}}:

with (nixpkgs.ocamlPackages_4_02_1);

nixpkgs.callPackage ./package.nix { inherit
    buildOcaml camlp4 core uint res ocplib-endian findlib
    pa_ounit pa_test;
    omake = nixpkgs.omake_rc1;}
