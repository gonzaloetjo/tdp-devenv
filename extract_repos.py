import json

with open('repos.json') as file:
    data = json.load(file)

for entry in data:
    org = entry['org']
    repos = entry['repos']
    for repo in repos:
        print(repo)
