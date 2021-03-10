![Generic badge](https://img.shields.io/badge/status-it_works-ok.svg)
![Generic badge](https://img.shields.io/badge/OS-MacOS%20|%20Ubuntu-blue.svg)
![Generic badge](https://img.shields.io/badge/Python-3.7--3.9-blue.svg)
[![Actions Status](https://github.com/rtmigo/pyrel/workflows/tests/badge.svg?branch=master)](https://github.com/rtmigo/pyrel/actions)

# [pyrel](https://github.com/rtmigo/pyrel)

This **bash script** will:

* build your Python **PyPi package** (with [twine](https://pypi.org/project/twine/))
* **install it locally** with pip3 into a temporary
  [virtual environment](https://docs.python.org/3/library/venv.html)
* let you **check whether it really installed** there

This is an intentionally minimalistic solution. (not like [tox](https://tox.readthedocs.io))

### Why I made this

I wanted a reusable script that was equally easy to run on a local machine and with
a [CI tool](https://github.com/actions) remotely. So the CI is optional and replaceable. CI just
invokes the same script that runs locally.

# What is pyrel

A single `pyrel.sh` file, that declares several bash functions. After you `source pyrel.sh`, you can
call previously unavailable commands such as `build_package`.

`pyrel.sh` is meant to be placed inside the project.

```
pythonproject
| myprogram          <-- python project files
| tests              <-- python project files
| setup.py           <-- python project files
|
| build_my_package.sh   <-- your script that use pyrel.sh
| test_my_package.sh    <-- your script that use pyrel.sh
| pyrel.sh              <-- also placed somewhere in the project

```

`pyrel.sh` contains most of the boilerplate code, so `test_package.sh` and `build_package.sh`
can be extremely short and simple.

# Install

`pyrel.sh` is a script file with no external dependencies. Just download it and place somewhere in
the project directory.

We assume you have a working **python3**, **pip3** and **python3-venv**.

# How to import

``` bash
#!/bin/bash
set -e && source path/to/pyrel.sh
```

The script should be run only from the project directory

``` bash
$ cd /abc/myproject
$ /xyz/script_that_use_pyrel.sh # this works

$ cd /abc/photos_(not_project)
$ /xyz/script_that_use_pyrel.sh  # shows error, does nothing
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

# Customizing

By default, the script runs the following to build the package:

``` bash
pip3 install setuptools wheel twine --force-reinstall
python3 setup.py sdist bdist_wheel
```

If you need to perform additional steps, there is no need to modify `pyrel.sh`. You can  
redefine `build_package` function directly in your script:

``` bash
#!/bin/bash
set -e && source pyrel.sh

function build_package() {
  # ... replace these lines with what you need ...
  pip3 install setuptools wheel twine --force-reinstall
  python3 setup.py sdist bdist_wheel
}

# continue as usual

pyrel_test_begin

myprogram --help       
myprogram --version
 
pyrel_test_end
```

# Functions

## Virtual environments

`pyrel_venv_begin` and `pyrel_venv_end` let you easy create and delete a virtual environment in a
temporary directory.

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