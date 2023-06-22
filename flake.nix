{
  inputs = {
    nixpkgs.url = "nixpkgs";
    flake-parts.url = "github:hercules-ci/flake-parts";

    pre-commit-hooks-nix.url = "github:cachix/pre-commit-hooks.nix";
    pre-commit-hooks-nix.inputs.nixpkgs.follows = "nixpkgs";

    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";

    treefmt.url = "path:/home/lbodor/dev/treefmt";
    treefmt.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake
    {inherit inputs;}
    {
      systems = ["x86_64-linux"];

      imports = [
        inputs.pre-commit-hooks-nix.flakeModule
        inputs.treefmt-nix.flakeModule
      ];

      perSystem = {
        config,
        pkgs,
        lib,
        inputs',
        ...
      }: {
        pre-commit = {
          check.enable = true;
          settings.hooks = {
            treefmt.enable = true;
          };
        };

        treefmt = {
          package = inputs'.treefmt.packages.default;
          projectRootFile = "flake.nix";

          build.check = self: pkgs.writeScript "disable-flake-check" ":";

          programs = {
            stylua.enable = true;
            alejandra.enable = true;
          };
          settings.formatter.stylua.options = [
            "--indent-type"
            "Spaces"
          ];
        };

        devShells.default = let
          treefmtPrograms = lib.attrsets.attrValues config.treefmt.build.programs;
        in
          pkgs.mkShellNoCC {
            packages =
              [
                config.treefmt.build.wrapper
              ]
              ++ treefmtPrograms;

            shellHook = ''
              ${config.pre-commit.installationScript}
              export TREEFMT_CONFIG=${config.treefmt.build.configFile}
            '';
          };
      };
    };
}
