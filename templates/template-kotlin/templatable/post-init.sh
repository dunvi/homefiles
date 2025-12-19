#! /usr/bin/env nix-shell
#! nix-shell -i bash -p gradle_8
#! nix-shell -I nixpkgs=channel:nixos-unstable

set -euo pipefail

if [[ -z "$1" ]] ; then
    echo "Missing module name. Aborting kotlin post-initialization."
    exit 1
fi

prj="${1//-/}"

# TODO: can we get correct java version from env?
gradle init --use-defaults \
    --type kotlin-application \
    --package me.dunvi.$prj \
    --project-name $prj \
    --no-split-project
