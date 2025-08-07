{
  description = "C compiler for processors of 6502 family";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-24.05";
  };

  outputs = { self, nixpkgs }:
    let
      allSystems = [
        "x86_64-linux"
        "x86_64-darwin"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      forAllSystems = f: nixpkgs.lib.genAttrs allSystems (system: f {
        inherit system;
        pkgs = import nixpkgs { inherit system; };
      });
    in {
      packages = forAllSystems ({ system, pkgs, ...}: {
        default = pkgs.gccStdenv.mkDerivation {
          name = "cc65";
          homepage = "https://cc65.github.io/";

          src = pkgs.fetchFromGitHub {
            owner = "cc65";
            repo = "cc65";
            rev = "6efe447d14a31e98cb14e8a3d45621e844c89ebe";
            sha256 = "sha256-aMG69Pj1CD0YkdTB60CDyWnsbu56B4HH+fZPtUDLBeU=";
          };
        
          makeFlags = [ "PREFIX=${placeholder "out"}" ];
        };
      });
    };
}
