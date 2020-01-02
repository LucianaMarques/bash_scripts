#!/usr/bin/env bash

set -euo pipefail

echo "Fetching changes in upstream"

git fetch upstream

echo "Cheking out to master branch"

git checkout master

echo "Merging changes into master branch"

git merge upstream/master
