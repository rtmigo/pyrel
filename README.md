![Generic badge](https://img.shields.io/badge/status-it_seems_to_work-orange.svg)
![Generic badge](https://img.shields.io/badge/OS-MacOS%20|%20Ubuntu-blue.svg)

# [pyrel](https://github.com/rtmigo/pyrel)

A single `pyrel.sh` file, that provides functions for building and testing Python 
packages.

```
pythonproject
| mypropram          <-- python project files
| tests              <-- python project files
| setup.py           <-- python project files
|
| build_my_package.sh   <-- a script that use pyrel
| test_my_package.sh    <-- a script that use pyrel
| pyrel.sh              <-- also placed somewhere in the project

```
`pyrel.sh` contains most of the boilerplate code, so `test_package.sh` and `build_package.sh` 
can be 
extremely short and simple.

# Install

`pyrel.sh` is a script file with no external dependencies. Just download it and place somewhere 
in the project directory.


# How to import 

When you import `pyrel`, you must be in the python project 
directory, i.e. the directory containing `setup.py`.

``` bash
$ cd /abc/myproject
$ source path/to/pyrel.sh  # ok because /abc/myproject/setup.py exists 
```

``` bash
$ cd /abc/photos_(not_project)
$ source path/to/pyrel.sh  # shows error, does nothing
```

So even if you place this into a `myscript.sh` ...

``` bash
#!/bin/bash
source path/to/pyrel.sh
```

The `myscript.sh` should only be called from the project directory

``` bash
$ cd /abc/myproject
$ ./myscript.sh
```


## Copy-paste


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

# Sample scripts

## How to test a module

``` bash
#!/bin/bash
set -e && source pyrel.sh

# build package, install it into virtual 
# environment with pip
pyrel_test_begin

# check, that we can import this module by name 
# (so it's installed) 
python3 -c "import mymodule"

# remove generated package 
pyrel_test_end
```

## How to test a command-line utility

``` bash
#!/bin/bash
set -e && source pyrel.sh

# build package, install it into virtual 
# environment with pip
pyrel_test_begin

# check, that we can run the program by name 
# (so it's visible from the $PATH) 
myprogram --help       
myprogram --version

# remove generated package 
pyrel_test_end
```

# Details

## Virtual environments

`pyrel_venv_begin` and `pyrel_venv_end` let you easy create and delete a virtual 
environment in a temporary directory.

``` bash
#!/bin/bash
set -e && source pyrel.sh

pyrel_venv_begin
# now running in a temporary virtual environment A
pyrel_venv_end

# the temporary environment A was deactivated and deleted

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

Temporary environments will be automatically removed on errors  

``` bash
#!/bin/bash

set -e  # we will fail on all errors 
source pyrel.sh 

pyrel_venv_begin

bad_command  # oops, exiting because of error 

pyrel_venv_end  # exiting, so not running this

# RELAX: bash will delete the temporary files anyway  
```

