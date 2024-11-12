#
#  These are the different profiles that can be used when building on MacOS
#
#  flake.nix
#   └─ ./darwin
#       ├─ default.nix *
#       ├─ darwin-configuration.nix
#       └─ <host>.nixx
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
  m1 = nix-darwin.lib.darwinSystem {
    system = "aarch64-darwin";
    specialArgs = { inherit inputs nixpkgs vars; };
    modules = [
      ./darwin-configuration.nix
      ./m1.nix
      home-manager.darwinModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
      }
      ({ pkgs, ... }: {
        # Here you can add any system-wide configuration
        # For example:
        # environment.systemPackages = [ pkgs.vim ];
      })
    ];
  };

    m3 = nix-darwin.lib.darwinSystem {
    system = "aarch64-darwin";
    specialArgs = { inherit inputs nixpkgs vars; };
    modules = [
      ./darwin-configuration.nix
      ./m3.nix
      home-manager.darwinModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
      }
      ({ pkgs, ... }: {
        # Here you can add any system-wide configuration
        # For example:
        # environment.systemPackages = [ pkgs.vim ];
      })
    ];
  };
}
