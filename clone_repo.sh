#!/usr/bin/env bash

set -e

# Check if YAML file exists
if [ ! -f "repos.yaml" ]; then
  echo "repos.yaml file is missing."
  exit 1
fi

repos=$(yq e '.repos[]' repos.yaml)

for org_info in "${repos[@]}"; do
    ORGANIZATION=$(yq e '.org' <<< "$org_info")
    REPOS=$(yq e '.value[]' <<< "$org_info")
    for REPO in $REPOS; do
      git clone https://github.com/$ORGANIZATION/$REPO.git $REPO-$ORGANIZATION
    done
done
