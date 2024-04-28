{
  description = "My NixOs configuration flake.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
	nix-ld.url = "github:Mic92/nix-ld";
	nix-ld.inputs.nixpkgs.follows = "nixpkgs";
	nix-alien.url = "github:thiagokokada/nix-alien";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nix-ld, home-manager, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
	  specialArgs = { inherit self system; };
      modules = [
	  		({ self, system, ... }: {
            environment.systemPackages = with self.inputs.nix-alien.packages.${system}; [
              nix-alien
            ];
            programs.nix-ld.enable = true;
          })
			nix-ld.nixosModules.nix-ld
        	./nixos/configuration.nix
        	home-manager.nixosModules.home-manager
          	{
            	home-manager.useGlobalPkgs = true;
            	home-manager.useUserPackages = true;
            	home-manager.users.yannis = import ./home/home.nix;
        	}
	  ];
    };
  };
}
