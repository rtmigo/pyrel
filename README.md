# pyrel

Bash functions for building and testing Python packages.

# Install

`pyrel.sh` is a small script file. `source` it in a Python project directory.

``` bash
$ cd /abc/myproject
$ source path/to/pyrel.sh
```

## Temporary virtual environments

Each environment is created in a temporary directory with `pyrel_venv_begin` and removed with
`pyrel_venv_end`.

``` bash
#!/bin/bash
set -e && source pyrel.sh

pyrel_venv_begin
# now running in a temporary virtual environment
pyrel_venv_end

pyrel_venv_begin
# now running in other temporary virtual environment
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





## Testing a command-line utility

``` bash
#!/bin/bash
set -e && source pyrel.sh

# build package, install it into virtual 
# environment with pip
pyrel_test_begin

# check, that we can run program by name 
myprogram --help       
myprogram --version

#remove_dist # remove generated package 
pyrel_test_end
```