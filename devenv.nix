{ inputs, pkgs, ... }:

let
  pkgs-stable = import inputs.nixpkgs-stable { system = pkgs.system; };
in {
    # https://devenv.sh/basics/
    env.GREET = "This is a TDP nix environment";

    # https://devenv.sh/packages/
    packages = [ 
      pkgs.git
      pkgs.jq
      pkgs.ansible
      pkgs.zip
      pkgs.unzip
      pkgs-stable.python39
      pkgs-stable.python39Packages.matplotlib
      pkgs-stable.python39Packages.jmespath
      pkgs-stable.python39Packages.graphviz 
      pkgs-stable.python39Packages.poetry
      pkgs-stable.python39Packages.numpy
      pkgs-stable.python39Packages.pip
      pkgs-stable.python39Packages.venvShellHook
      pkgs-stable.nodejs
    ];

    enterShell = ''
      hello
      git --version
      ansible --version
    '';

    # https://devenv.sh/languages/
    # languages.nix.enable = true;

    # https://devenv.sh/scripts/
    # scripts.hello.exec = /tdp/scripts/script.sh;

    # https://devenv.sh/pre-commit-hooks/
    # pre-commit.hooks.shellcheck.enable = true;

    # https://devenv.sh/processes/
    # processes.ping.exec = "ping example.com";
}
