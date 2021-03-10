#!/bin/bash
set -e && source "scripts/pyrel.sh"

pyrel_test_begin # check it builds

# check we can import it
python3 -c "import greeter"

# or run a function and save the output to a file
python3 -c "import greeter; greeter.say_hi()" > ~/output.txt

pyrel_test_end # cleanup