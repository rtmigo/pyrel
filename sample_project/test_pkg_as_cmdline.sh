#!/bin/bash
set -e && source "scripts/pyrel.sh"

pyrel_test_begin # check it builds

# check it runs
greeter
# also save the output to a file
greeter > ~/output.txt

pyrel_test_end # cleanup