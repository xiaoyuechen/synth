{
  outputs = {self, nixpkgs, flake-utils}:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; };
      in with pkgs; {
        packages.default = stdenv.mkDerivation {
          name = "synth-20090114";
          src = ./.;
          installPhase = ''
            mkdir -p $out/bin
            cp chains synth acm $out/bin
          '';
        };

        devShells.default = mkShell {
          inputsFrom = [ self.packages.${system}.default ];
          packages = [ graphviz xdot ];
        };
      }
    );
}
