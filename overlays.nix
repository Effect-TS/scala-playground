{
  nixpkgs,
  system,
  ...
}: let
  # Helper to create a custom Java overlay
  javaOverlay = java: final: prev: {
    jdk = final.${java};
    jre = final.${java};
  };

  pkgs17 = import nixpkgs {
    inherit system;
    overlays = [javaOverlay "graalvm17-ce"];
  };
  pkgs11 = import nixpkgs {
    inherit system;
    overlays = [javaOverlay "graalvm11-ce"];
  };
  pkgs8 = import nixpkgs {
    inherit system;
    overlays = [javaOverlay "openjdk8"];
  };
in {
  inherit pkgs17 pkgs11 pkgs8;
  default = pkgs17;
}
