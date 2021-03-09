#!/bin/bash
set -e

# pulls the newest pyrel as a subtree from github

cd "${0%/*}/../.."
git subtree pull -m "update pyrel" --prefix scripts/pyrel https://github.com/rtmigo/pyrel master --squash
