{
  description = "Home Manager configuration of flo";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    krewfile = {
      url = "github:brumhard/krewfile";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, krewfile, fenix, ... }:
    let
      system = "x86_64-linux";
      #pkgs = nixpkgs.legacyPackages.${system};
      pkgs = import nixpkgs{
        inherit system;
        overlays = [ fenix.overlays.default];
      };
    in {
      #nixpkgs.overlays = [ fenix.overlays.default ];
      homeConfigurations."flo" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home.nix
          krewfile.homeManagerModules.default
        ];
      };
    };
}
