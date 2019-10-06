#!/bin/bash

# This script iterates all branches of a repo and tags them.
# Needed for Elixir cross referencer database update 

for branch in $(git for-each-ref --shell --format='%(objectname)'); do
    RND=$(shuf -i 1-1000 -n 1)
    SHA=$(echo ${branch} | tr -d "'")
    git tag -a v0.${RND} ${SHA} -m "Needed by Elixir"
done
