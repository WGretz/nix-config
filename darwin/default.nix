#
#  These are the different profiles that can be used when building on MacOS
#
#  flake.nix
#   └─ ./darwin
#       ├─ default.nix *
#       ├─ darwin-configuraiton.nix
#       └─ <host>.nix
#

{ inputs, nixpkgs, nix-darwin, home-manager, vars, ... }:

let
  systemConfig = system: {
    system = system;
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  };
in
{
  m1 =
    let
      inherit (systemConfig "aarch64-darwin") system pkgs;
    in
    builtins.trace "system: ${system}" {
      inherit system;
      specialArgs = { inherit inputs system pkgs vars; };
      modules = [
        ./darwin-configuration.nix
        ./m1.nix
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
        }
      ];
    };
}
