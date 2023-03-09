#!/usr/bin/env bash
set -e
cd "$(dirname "$0")"

# This script simply prepares ../game for running in place (dev environment)

rsync --recursive --perms --links --ignore-times --exclude='*.bat' --exclude='*.dll' ./copy/ ../game/

../game/link.sh "$1"