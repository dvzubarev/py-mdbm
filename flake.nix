{
  description = "Python wrapper for mdbm";

  inputs = {
    textapp-pkgs.url = "git+ssh://git@tsa04.isa.ru/textapp/textapp-pkgs";
  };

  outputs = { self,  textapp-pkgs }:
    let pkgs = import textapp-pkgs.inputs.nixpkgs {
          system = "x86_64-linux";
          overlays = [ textapp-pkgs.overlays.default ];
        };
        # python-overlay = pyfinal: pyprev: {pywordsdb = pyfinal.callPackage ./nix {src=self;};};
        tlib = textapp-pkgs.lib;
        pypkgs = pkgs.python.pkgs;
    in {



      devShells.x86_64-linux.default =
        pkgs.mkShell {
          # inputsFrom = [ pypkgs.pywordsdb ];
          buildInputs = [
            (pkgs.python.withPackages( p: [ p.setuptools ] ))
            pkgs.mdbm
            pkgs.ccls
            # pypkgs.pythonDevHook
          ];
          shellHook = '''';

        };
    };

}
