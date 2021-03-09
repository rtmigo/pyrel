# pyrel

Bash functions for building and testing Python packages.

# Install

`pyrel.sh` is just a small script file meant to be included when you're at the project root:

```bash
cd /abc/myproject
source path/to/pyrel.sh
```

# Test a command-line utility

When building a package that should be installed as a command line utility with pip3.  


```bash
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

- **pyrel**: builds a package from the python module
- **pyrel**: uses pip3 to install the newly built package into a virtual environment
- **user**: calls the program by name (so we'll know it is added to path)
- **user**: optionally runs it again (so we'll know the program ends without error code)
- **pyrel**: deletes all the temp files created
