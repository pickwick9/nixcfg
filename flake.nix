{
  description = "allen's nix config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-2405.url = "nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-2405, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-2405 = nixpkgs-2405.legacyPackages.${system};
    in {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          pkgs-2405 = import nixpkgs-2405 { inherit system; config.allowUnfree = true; };
        };
        modules = [ ./allen/configuration.nix ];
      };
      homeConfigurations = {
        allen = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ allen/home.nix ];
        };
      };
    };
}
