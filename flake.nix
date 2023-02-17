{
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-22.11";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    ...
  }: let
    forAllSystems = nixpkgs.lib.genAttrs [
      "x86_64-darwin"
      "x86_64-linux"
      "aarch64-darwin"
      "aarch64-linux"
    ];

    pkgsFor = system: nixpkgs.legacyPackages.${system};

    javaOverlay = java: (final: _: {
      jdk = final.${java};
      jre = final.${java};
    });

    javaOverlays = {
      java17 = javaOverlay "graalvm17-ce";
      java11 = javaOverlay "graalvm11-ce";
      java8 = javaOverlay "openjdk8";
    };
  in {
    formatter = forAllSystems (
      system: let
        pkgs = pkgsFor system;
      in
        pkgs.alejandra
    );

    devShells = forAllSystems (system: let
      pkgs = pkgsFor system;
    in {
      default = pkgs.callPackage "${self}/shell.nix" {
        pkgs = import nixpkgs {
          inherit system;
          overlays = [javaOverlays.java8];
        };
      };
      java17 = pkgs.callPackage "${self}/shell.nix" {
        pkgs = import nixpkgs {
          inherit system;
          overlays = [javaOverlays.java17];
        };
      };
      java11 = pkgs.callPackage "${self}/shell.nix" {
        pkgs = import nixpkgs {
          inherit system;
          overlays = [javaOverlays.java11];
        };
      };
      java8 = pkgs.callPackage "${self}/shell.nix" {
        pkgs = import nixpkgs {
          inherit system;
          overlays = [javaOverlays.java8];
        };
      };
    });
  };
}
