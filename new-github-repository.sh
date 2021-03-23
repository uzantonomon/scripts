#!/bin/bash

# No checks and zero defensive. With hardcoded stuff.

set -eou pipefail

. ~/scripts/secrets

echo "what's the name of the repo?"

read -r REPO_NAME

curl -i -H "Authorization: token $TOKEN" -d '{ "name": "'$REPO_NAME'" }' https://api.github.com/user/repos

mkdir -p ~/projects/"$REPO_NAME"
cd ~/projects/"$REPO_NAME" || exit

echo "# $REPO_NAME" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin git@github.com:uzantonomon/"$REPO_NAME".git
git push -u origin main

cd ~/projects/$REPO_NAME
