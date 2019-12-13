#!/usr/bin/env bash

set -euo pipefail

if ! git rev-parse --is-inside-work-tree > /dev/null; then
  echo This is not a git working directory
  echo Aborting script
  exit 1
fi

CURRENT_BRANCH="$(git symbolic-ref --short HEAD)"

echo Rebasing into master branch

git pull --rebase origin master

echo Current branch: "$CURRENT_BRANCH"

echo Amend pulled changes into previous commit [Y/n]?

read -r amend_answer

if [[ $amend_answer == "n" ]]; then
  echo Not ammending changes into previous commit
  echo Aborting script
  exit 1
fi

git commit --amend --no-edit

echo Force push to origin "$CURRENT_BRANCH" [Y/n]?

read -r force_push_answer

if [[ $force_push_answer == "n" ]]; then
  echo Not forcing push
  echo Finish script
  exit 1
fi

git push origin HEAD --force
