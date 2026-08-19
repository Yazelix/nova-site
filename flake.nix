{
  description = "Yazelix Nova site tooling";

  outputs =
    { self }:
    let
      system = "x86_64-linux";
      toolchain = import ./drafts/recordings/toolchain.nix { inherit system; };
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
    };
}
