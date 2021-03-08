# [draft] pyrel 

Reusable bash scrips that:

- build a package from the python module
- install a newly built package into a virtual environment
- let the user run the module
- delete all the temp files created

These files should not be executed directly (so they miss +x).



# Install

The scripts are not installed. They reside inside a python project directory.

### If you prefer SVN

The same command will get sources and update them later.

```bash
$ cd /abc/pythonproject
$ svn export https://github.com/rtmigo/pyrel/trunk scripts/pyrel --force
```

### If you prefer GIT submodules

Add to project:

```bash
$ cd /abc/pythonproject
$ git submodule add https://github.com/rtmigo/pyrel scripts/pyrel
```

Update to latest version:
```bash
git submodule update --remote
```

Lay code like that:

```
projectroot
| myprogram/
| scripts/pyrel/   <-- the scripts belong here
| setup.py
| ... etc ...
| test_pkg.sh
```

Sample test_pkg.sh:

```
#!/bin/bash
set -e

## SETUP ##
source scripts/pyrel/setup.inc.sh

## TEST ##
myprogram --version

## TEAR DOWN ##
cd "$scriptParentDir"
source scripts/pyrel/teardown.inc.sh
```