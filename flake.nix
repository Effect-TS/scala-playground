{
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixpkgs-unstable";
    };

    flake-utils = {
      url = "github:numtide/flake-utils";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      javaOverlay = java: (final: _: {
        jdk = final.${java};
        jre = final.${java};
      });

      javaOverlays = {
        java17 = javaOverlay "graalvm17-ce";
        java11 = javaOverlay "graalvm11-ce";
        java8 = javaOverlay "openjdk8";
      };

      pkgs = nixpkgs.legacyPackages.${system};

      makeBuildInputs = pkgs: (with pkgs; [
        alejandra
        coursier
        git
        jdk
        nix
        nil
        scalafmt
        scala-cli
      ]);
    in {
      formatter = pkgs.alejandra;

      devShells = {
        default = pkgs.mkShell {
          buildInputs = makeBuildInputs (import nixpkgs {
            inherit system;
            overlays = [javaOverlays.java17];
          });
        };

        java8 = pkgs.mkShell {
          buildInputs = makeBuildInputs (import nixpkgs {
            inherit system;
            overlays = [javaOverlays.java8];
          });
        };

        java11 = pkgs.mkShell {
          buildInputs = makeBuildInputs (import nixpkgs {
            inherit system;
            overlays = [javaOverlays.java11];
          });
        };

        java17 = pkgs.mkShell {
          buildInputs = makeBuildInputs (import nixpkgs {
            inherit system;
            overlays = [javaOverlays.java17];
          });
        };
      };
    });
}
