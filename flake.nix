{
  description = "C compiler for processors of 6502 family";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-24.05";
  };

  outputs = { self, nixpkgs }: {
    packages.x86_64-linux.default =
      let
        system = "x86_64-linux";
        pkgs = import nixpkgs { inherit system; };
      in pkgs.gccStdenv.mkDerivation {
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
    };
}
