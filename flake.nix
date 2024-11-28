{
  description = "allen's nix config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
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
