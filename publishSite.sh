#!/bin/sh

if [[ $(git status -s) ]]
then
    echo "The working directory is dirty. Please commit any pending changes."
    exit 1;
fi

echo "Deleting old publication"
rm -rf public
git worktree prune
rm -rf .git/worktrees/public/
mkdir public

echo "Checking out main branch into public"
git worktree add -B main public origin/main

echo "Removing existing files"
rm -rf public/*

echo "Generating site"
#hugo

echo "Updating main branch"
cd public && git add --all && git commit -m "Publish to main (publish.sh)" && git push