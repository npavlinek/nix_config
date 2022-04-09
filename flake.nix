{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-21.11";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-21.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, sops-nix, home-manager }:
  let
    system = "x86_64-linux";
  in {
    nixosConfigurations = {
      fulgrim = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./machines/fulgrim/configuration.nix
          sops-nix.nixosModules.sops
        ];
      };
    };

    homeConfigurations = {
      np = home-manager.lib.homeManagerConfiguration {
        inherit system;
        username = "np";
        homeDirectory = "/home/np";
        configuration = {
          imports = [
            ./user/home.nix
          ];
        };
      };
    };
  };
}
