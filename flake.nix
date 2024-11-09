{
  description = "Wilhelm's system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, nix-homebrew }:
    let
      vars = {
        user = "will";
        location = "$HOME/.setup";
        terminal = "kitty";
        editor = "nvim";
      };
    in
    {
      darwinConfigurations = import ./darwin {
        inherit (nixpkgs) lib;
        inherit inputs nixpkgs nix-darwin home-manager vars;
      };

      darwinModules = {
        inherit (nix-homebrew) darwinModules;
      };

      darwinPackages = {
        inherit (nix-homebrew) darwinPackages;
      };

    };
}
