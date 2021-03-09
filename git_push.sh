#!/bin/bash
set -e

# pushes the pyrel subtree to github

if [ "$#" -ne 1 ]; then
  echo "Usage: $(basename "$0") <commit message>"
  exit 2
fi

cd "${0%/*}/../.."
git subtree push -m "$1" --prefix scripts/pyrel https://github.com/rtmigo/pyrel master --squash
