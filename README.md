# TDP Dev environment

## Overview

This repository contains tools for creating a custom build of the Apache Airflow package, version 2.6.1, with additional dependencies. The build is wrapped in a Docker image, ready for deployment in a Docker-compatible environment.

The process uses four main components:

1. `devenv` Environment: A declarative Nix environment setup that outlines required system packages and host configurations.

2. Some scripts that set up the repositories required for deployment.


## TODO

[] Symlinks to use different repositories depending in what I want.
[] Script launch to be optional
[] Clean conf and scripts