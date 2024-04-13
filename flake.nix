{
  description = "A nixos configuration flake";

  inputs = {
    # NixOS official package source, using the nixos-23.11 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
	nix-ld.url = "github:Mic92/nix-ld";
	nix-ld.inputs.nixpkgs.follows = "nixpkgs";
	nix-alien.url = "github:thiagokokada/nix-alien";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with
      # the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs.
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
            # Optional, needed for `nix-alien-ld`
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
