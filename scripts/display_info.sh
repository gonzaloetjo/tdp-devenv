#!/usr/bin/env bash

# Define colors
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
RESET=$(tput sgr0)

# Define column widths - Update these based on your actual data
repository_width=30
origin_org_width=12
branch_width=20
commit_width=15
date_width=17

# Define line separator
LINE="${BLUE}+$(printf "%-${repository_width}s" | tr ' ' '-')+$(printf "%-${origin_org_width}s" | tr ' ' '-')+$(printf "%-${branch_width}s" | tr ' ' '-')+$(printf "%-${commit_width}s" | tr ' ' '-')+$(printf "%-${date_width}s" | tr ' ' '-')+${RESET}"

# Print the header of the table
echo $LINE
printf "${BLUE}| %-$((${repository_width}-2))s | %-$((${origin_org_width}-2))s | %-$((${branch_width}-2))s | %-$((${commit_width}-2))s | %-$((${date_width}-2))s |${RESET}\n" "Repository" "Origin Org" "Branch" "Current Commit" "Last Commit Date"
echo $LINE

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
    repo_dir="${repo}-${org}"
    if [ -d "$repo_dir" ]; then
      cd "$repo_dir"
      origin=$(git config --get remote.origin.url)
      origin_org=$(echo $origin | awk -F '[/:]' '{print $(NF-1)}')
      branch=$(git rev-parse --abbrev-ref HEAD)
      commit=$(git rev-parse --short HEAD)
      commit_date=$(git show -s --format="%cd" --date=format:"%Y-%m-%d %H:%M" $commit)
      printf "| %-$((${repository_width}-2))s | %-$((${origin_org_width}-2))s | %-$((${branch_width}-2))s | %-$((${commit_width}-2))s | %-$((${date_width}-2))s |\n" $repo $origin_org $branch $commit "$commit_date"
      echo $LINE
      cd ..
    else
      echo "${RED}Repository directory $repo_dir does not exist${RESET}"
    fi
  done
done
