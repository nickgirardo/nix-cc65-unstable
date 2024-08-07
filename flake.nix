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
            rev = "03d824e13b5e01d23d19c0150081a3024b539acd";
            sha256 = "sha256-/mR85D6hMytjICIH2CLCNsRFdWz/4LqehWhYNAKIctM=";
          };
        
          makeFlags = [ "PREFIX=${placeholder "out"}" ];
        };
      });
    };
}
