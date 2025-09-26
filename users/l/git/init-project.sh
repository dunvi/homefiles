#!/usr/bin/env bash

set -euo pipefail

if [[ -z "$1" ]] ; then
    echo "No destination given. Aborting."
    exit 1
fi

case "$2" in
    android|go|kotlin)
        :
        ;;
    java|python|ruby)
        echo "This template is not fully configured. Aborting."
        exit 1
        ;;
    *)
        echo "Invalid template language given ($2). Aborting."
        exit 1
        ;;
esac

read -p "Templating $2 to directory $1. Continue? (y/n) " -n1 answer
echo ""
if [[ "$answer" != "y" ]] ; then
    echo "Aborting new project initialization."
    exit 1
fi

cd ~/sources
mkdir $1

cd ~/sources/template-$2
while read file ; do
    cp -R $file ~/sources/$1/$file
done < ./templatable/files.txt

if [[ -f ./templatable/post-init.sh ]] ; then
    cp ./templatable/post-init.sh ~/sources/$1/post-init.sh
fi

cd ~/sources/$1

if [[ -f ./post-init.sh ]] ; then
    ./post-init.sh $1
    rm ./post-init.sh
fi

git init

if [[ "${3-}" == "--no-commit" ]] ; then
    echo "New project $1 initialized but not committed."
    exit 0
fi

git add .
git commit -m "initializing new project $1"

echo "New project $1 successfully initialized."
