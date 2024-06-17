{
  description = "My NixOs configuration flake.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-ld.url = "github:Mic92/nix-ld";
    nix-ld.inputs.nixpkgs.follows = "nixpkgs";
    nix-alien.url = "github:thiagokokada/nix-alien";
    nix-colors.url = "github:misterio77/nix-colors";
    spicetify-nix.url = "github:the-argus/spicetify-nix";
    nixify.url = "github:stannls/nixify";
	bandrip.url = "github:stannls/bandrip";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nix-ld, home-manager, nix-colors, spicetify-nix, ... }@inputs:
    let
      inherit (self) outputs;
      # Supported systems for your flake packages, shell, etc.
      systems = [
        "aarch64-linux"
        "i686-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      # This is a function that generates an attribute by calling a function you
      # pass to it, with each system as an argument
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
      overlays = import ./overlays { inherit inputs; };

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
              inherit spicetify-nix;
              inherit inputs;
              inherit outputs;
            };
            home-manager.useUserPackages = true;
            home-manager.users.yannis = import ./home/home.nix;
          }
        ];
      };

      nixosConfigurations.laptop-old = nixpkgs.lib.nixosSystem rec {
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
          ./nixos/laptop-old/configuration.nix
          # Home manager config
          home-manager.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = {
              inherit nix-colors;
              inherit spicetify-nix;
              inherit inputs;
              inherit outputs;
            };
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
              inherit spicetify-nix;
              inherit inputs;
              inherit outputs;
            };
            home-manager.useUserPackages = true;
            home-manager.users.yannis = import ./home/home.nix;
          }
        ];
      };
    };
}
