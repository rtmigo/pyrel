#!/bin/bash
set -e && source "scripts/pyrel.sh"

pyrel_test_begin # check it builds
greeter # check it runs
pyrel_test_end # cleanup