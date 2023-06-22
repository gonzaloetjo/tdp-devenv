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
      pkgs-stable.nodePackages.typescript
    ];

    hosts = {
      "worker-01.tdp" = "192.168.56.14";
      "worker-02.tdp" = "192.168.56.15";
      "worker-03.tdp" = "192.168.56.16";
      "master-01.tdp" = "192.168.56.11";
      "master-02.tdp" = "192.168.56.12";
      "master-03.tdp" = "192.168.56.13";
      "edge-01.tdp" = "192.168.56.10";
    };

  enterShell = ''
    echo -e "\\033[1;34m*********************************************************\\033[0m"
    echo -e "\\033[1;34m*                                                       *\\033[0m"
    echo -e "\\033[1;34m*    \\033[1;32mWelcome to the Nix dev environment for TDP!\\033[1;34m        *\\033[0m"
    echo -e "\\033[1;34m*                                                       *\\033[0m"
    echo -e "\\033[1;34m*    For more information, please visit:                *\\033[0m"
    echo -e "\\033[1;36m*    https://github.com/TOSIT-IO/tdp-getting-started/   *\\033[0m"
    echo -e "\\033[1;34m*                                                       *\\033[0m"
    echo -e "\\033[1;34m*********************************************************\\033[0m"
    echo -e "\\033[1;33mGit version:\\033[0m"
    git --version
    echo -e "\\033[1;33mAnsible version:\\033[0m"
    ansible --version
    echo -e "\\033[1;33mPython version:\\033[0m"
    python --version
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
