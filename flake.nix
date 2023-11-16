{
  inputs = {
    # Track a specific tag on the nixpkgs repo.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # The flake format itself is very minimal, so the use of this
    # library is common.
    flake-utils.url = "github:numtide/flake-utils";
  };

  # Here we can define various kinds of "outputs": packages, tests, 
  # and so on, but we will only define a development shell.

  outputs = { nixpkgs, flake-utils, ... }:

    # For every platform that Nix supports, we ...
    flake-utils.lib.eachDefaultSystem (system:

      # ... get the package set for this particular platform ...
      let
        pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
        PROJECT_ROOT = builtins.toString ./.;
      in {

        # ... and define a development shell for it ...
        devShells.default =

          # ... with no globally-available CC toolchain ...
          (pkgs.mkShell.override { stdenv = pkgs.llvmPackages_16.stdenv; })  {
            name = "hetzner_kube";

            # ... which makes available the following dependencies, 
            # all sourced from the `pkgs` package set:
            packages = with pkgs; [
              git-crypt
              kubectl
              hcloud
              terraform
              ansible
            ];

            env = {
              TF_VAR_SSH_PATH="${PROJECT_ROOT}/secrets/.ssh/kubekeys.pub";
              ANSIBLE_PRIVATE_KEY_FILE="${PROJECT_ROOT}/secrets/.ssh/kubekeys";
              ANSIBLE_HOST_KEY_CHECKING = "False";
              TF_VAR_hcloud_token = (builtins.readFile ./secrets/hcloud.token);
              KUBECONFIG = "./config/kubeconfig";
            };
          };
      });
}
