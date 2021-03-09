# pyrel

Bash functions for building and testing Python packages.

# Install

`pyrel.sh` is a script file with no external dependencies. Just download it and `source` in a Python project directory.

``` bash
$ cd /abc/myproject
$ source path/to/pyrel.sh
```

# Samples

## Import the pyrel

``` bash
#!/bin/bash
set -e && source path/to/pyrel.sh
```

You can also use a path relative to the calling script

``` bash
#!/bin/bash
set -e && source "${0%/*}/scripts/pyrel.sh"

# current file:  project/this.sh
# imported file: project/scripts/pyrel.sh
```

## Test for a command-line utility

``` bash
#!/bin/bash
set -e && source pyrel.sh

# build package, install it into virtual 
# environment with pip
pyrel_test_begin

# check, that we can run program by name 
myprogram --help       
myprogram --version

# remove generated package 
pyrel_test_end
```

# Details

## Temporary virtual environments

``` bash
#!/bin/bash
set -e && source pyrel.sh

pyrel_venv_begin
# now running in a temporary virtual environment A
pyrel_venv_end

# the temporary enviroment A was deactivated and deleted

pyrel_venv_begin
# now running in a temporary virtual environment B
pyrel_venv_end
```

Nesting is not supported

``` bash
# BAD example:
pyrel_venv_begin
pyrel_venv_begin
# ...
pyrel_venv_end
pyrel_venv_end
```

Temporary environments will be removed on errors too  

``` bash
#!/bin/bash

set -e  # we will fail on all errors 
source pyrel.sh 

pyrel_venv_begin

bad_command  # oops, exiting because of error 

pyrel_venv_end  # exiting, so not running this

# RELAX: bash will delete the temporary files anyway  
```

