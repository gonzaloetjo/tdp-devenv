#!/usr/bin/env bash

# Check if JSON file exists
if [ ! -f "repos.json" ]; then
  echo "repos.json file is missing."
  exit 1
fi

# Parse JSON file into a variable
data=$(cat repos.json)

# Extract organizations
orgs=$(echo $data | jq -r '.[] | .org')

for org in $orgs
do
  # Get the repos for the organization
  repos=$(echo $data | jq -r --arg org "$org" '.[] | select(.org == $org) | .repos[]')

  for repo in $repos
  do
    git clone https://github.com/$org/$repo.git $repo-$org
  done
done
