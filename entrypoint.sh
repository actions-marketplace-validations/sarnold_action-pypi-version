#! /usr/bin/env bash

echo "Declare local repo checkout 'safe' for consumption..."
git config --global --add safe.directory /github/workspace
