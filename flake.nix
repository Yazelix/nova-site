{
  description = "Yazelix Nova site tooling";

  inputs.kinestra.url = "github:Yazelix/kinestra";

  outputs =
    { self, kinestra }:
    let
      system = "x86_64-linux";
      pkgs = kinestra.inputs.nixpkgs.legacyPackages.${system};
      recorder = kinestra.lib.${system}.mkRecorder {
        name = "record-nova-demo";
        recipe = ./drafts/recordings/record.rs;
        runtimeInputs = [
          pkgs.git
          pkgs.zoxide
        ];
      };
    in
    {
      apps.${system} = rec {
        record-demo = {
          type = "app";
          program = "${recorder}/bin/record-nova-demo";
        };
        default = record-demo;
      };

      packages.${system} = {
        record-demo = recorder;
        default = recorder;
      };
    };
}
