#!/usr/bin/env bash
set -e
shopt -s globstar  # Allow ** to use recursive globbing
cd "$(dirname "$0")"

# This script creates game_dist.tar.gz and game_dbg.tar.gz (containing split debuginfo)
echo "Copying game_clean/copy"
rsync --recursive --perms --links --ignore-times --exclude='*.bat' --exclude='*.dll' ./copy/ ../game/

cd ../game

if test -n "$(shopt -s nullglob; echo **/*.vpk)"; then
	echo "This game folder seems to have been set up for development running."
	echo "Please regenerate it without running create_devenv.sh."
	exit 1
fi

echo "Packing $(dirname ${PWD})/game_dist_linux32.tar.gz"
tar --create --file ../game_dist_linux32.tar.gz --gzip --exclude='*.dbg' --exclude='*.map' .
echo "Packing $(dirname ${PWD})/game_dbg_linux32.tar.gz"
tar --create --file ../game_dbg_linux32.tar.gz --gzip **/*.dbg **/*.map
