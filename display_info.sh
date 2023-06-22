#!/usr/bin/env bash

# Define colors
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
RESET=$(tput sgr0)

# Print the header of the table
echo "${BLUE}+-----------------------+--------------+---------------+-----------------+-------------------+${RESET}"
printf "${BLUE}| %-21s | %-12s | %-13s | %-15s | %-17s |${RESET}\n" "Repository" "Origin Org" "Branch" "Current Commit" "Last Commit Date"
echo "${BLUE}+-----------------------+--------------+---------------+-----------------+-------------------+${RESET}"

# Get number of organizations
num_orgs=$(yq e 'length' repos.yaml)

for (( i=0; i<$num_orgs; i++ ))
do
  # Get organization and its repos
  ORGANIZATION=$(yq e ".[$i].org" repos.yaml)
  num_repos=$(yq e ".[$i].repos | length" repos.yaml)

  for (( j=0; j<$num_repos; j++ ))
  do
    REPO=$(yq e ".[$i].repos[$j]" repos.yaml)
    repo_dir="${REPO}-${ORGANIZATION}"
    if [ -d "$repo_dir" ]; then
      cd "$repo_dir"
      origin=$(git config --get remote.origin.url)
      origin_org=$(echo $origin | awk -F '[/:]' '{print $(NF-1)}')
      branch=$(git rev-parse --abbrev-ref HEAD)
      commit=$(git rev-parse --short HEAD)
      commit_date=$(git show -s --format="%cd" --date=format:"%Y-%m-%d %H:%M" $commit)
      printf "| %-21s | %-12s | %-13s | %-15s | %-17s |\n" $REPO $origin_org $branch $commit "$commit_date"
      echo "${BLUE}+-----------------------+--------------+---------------+-----------------+-------------------+${RESET}"
      cd ..
    else
      echo "${RED}Repository directory $repo_dir does not exist${RESET}"
    fi
  done
done
