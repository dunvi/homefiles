#! /usr/bin/env nix-shell
#! nix-shell -i bash -p go

set -euo pipefail

if [[ -z "$1" ]] ; then
    echo "Missing module name. Aborting golang post-initialization."
    exit 1
fi

go mod init github.com/dunvi/$1
