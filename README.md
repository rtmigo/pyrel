# pyrel

Bash functions for building and testing Python packages.

# Install

`pyrel.sh` is a small script file. `source` it in a Python project directory.

``` bash
$ cd /abc/myproject
$ source path/to/pyrel.sh
```

## Testing a command-line utility

``` bash
#!/bin/bash
set -e && source pyrel.sh

# build package, install it into virtual 
# environment with pip
package_test_setup

# check, that we can run program by name 
myprogram --help       
myprogram --version

remove_dist # remove generated package 
package_test_teardown # remove temporary files
```