{
  description = "Yazelix Nova site tooling";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/83199d0d373dd3ac2b9a1996b1d0263f76ab7a4c";
    playwright-web.url = "github:pietdevries94/playwright-web-flake/1.62.1";
  };

  outputs =
    {
      self,
      nixpkgs,
      playwright-web,
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      toolchain = import ./drafts/recordings/toolchain.nix { inherit system; };
      playwrightBrowsers =
        playwright-web.packages.${system}.playwright-driver.selectBrowsers {
          withFirefox = false;
          withWebkit = false;
        };
    in
    {
      apps.${system} = rec {
        record-demo = {
          type = "app";
          program = "${toolchain}/bin/record-nova-demo";
        };
        default = record-demo;
      };

      packages.${system} = {
        record-demo = toolchain;
        default = toolchain;
      };

      devShells.${system}.default = pkgs.mkShell {
        packages = [
          pkgs.actionlint
          pkgs.bun
          pkgs.ffmpeg
          pkgs.nodejs_24
          pkgs.typos
          toolchain
        ];

        PLAYWRIGHT_BROWSERS_PATH = "${playwrightBrowsers}";
        PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD = "1";
        PLAYWRIGHT_SKIP_VALIDATE_HOST_REQUIREMENTS = "true";
      };
    };
}
