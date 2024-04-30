{
  description = "My NixOs configuration flake.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-ld.url = "github:Mic92/nix-ld";
    nix-ld.inputs.nixpkgs.follows = "nixpkgs";
    nix-alien.url = "github:thiagokokada/nix-alien";
    nix-colors.url = "github:misterio77/nix-colors";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nix-ld, home-manager, nix-colors, ... }@inputs: {
    nixosConfigurations.desktop = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      specialArgs = { inherit self system; };
      modules = [
        # Dynamic linking shenanigans
        ({ self, system, ... }: {
          environment.systemPackages = with self.inputs.nix-alien.packages.${system}; [
            nix-alien
          ];
          programs.nix-ld.enable = true;
        })
        nix-ld.nixosModules.nix-ld

        # Nixos config
        ./nixos/default.nix
        ./nixos/desktop/configuration.nix
        # Home manager config
        home-manager.nixosModules.home-manager
        {
          home-manager.extraSpecialArgs = {
            inherit nix-colors;
          };
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.yannis = import ./home/home.nix;
        }
      ];
    };

    nixosConfigurations.laptop = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      specialArgs = { inherit self system; };
      modules = [
        # Dynamic linking shenanigans
        ({ self, system, ... }: {
          environment.systemPackages = with self.inputs.nix-alien.packages.${system}; [
            nix-alien
          ];
          programs.nix-ld.enable = true;
        })
        nix-ld.nixosModules.nix-ld

        # Nixos config
        ./nixos/default.nix
        ./nixos/laptop/configuration.nix
        # Home manager config
        home-manager.nixosModules.home-manager
        {
          home-manager.extraSpecialArgs = {
            inherit nix-colors;
          };
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.yannis = import ./home/home.nix;
        }
      ];
    };
  };
}
