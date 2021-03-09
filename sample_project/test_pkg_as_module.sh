#!/bin/bash
set -e && source "scripts/pyrel.sh"

pyrel_test_begin # check it builds
python3 -c "import greeter; greeter.say_hi()"
pyrel_test_end # cleanup