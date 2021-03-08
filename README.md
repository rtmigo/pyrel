# [draft] pyrel 

Reusable bash scrips that:

- build a package from the python module
- install a newly built package into a virtual environment
- let the user run the module
- delete all the temp files created

These files should not be executed directly (so they miss +x).



# Install

The scripts should not be installed to the system. They are placed inside a python project directory.

<details>
<summary>If you prefer GIT submodules.</summary><br/>

Git submodule will kinda add the scripts to the repository. But in many cases you will find files 
of the module are missing. 

Create `/abc/pythonproject/scripts/pyrel`:

```bash
$ cd /abc/pythonproject
$ git submodule add https://github.com/rtmigo/pyrel scripts/pyrel
```

Update to latest version:
```bash
$ cd /abc/pythonproject
$ git submodule update --remote
```

Remove the submodule:

```bash
$ cd /abc/pythonproject
$ git rm scripts/pyrel -f
$ rm -rf .git/modules/scripts/pyrel
```
</details>

## If you prefer SVN

Create `/abc/pythonproject/scripts/pyrel`:

```bash
$ cd /abc/pythonproject
$ svn export https://github.com/rtmigo/pyrel/trunk scripts/pyrel --force
```

Update with the same command.

# Use

The expected project layout is something like that:

```
pythonproject
| myprogram/
| scripts/pyrel/   <-- the scripts belong here
| setup.py
| ... etc ...
| test_pkg.sh      <-- we will automate testing here
```

Sample `test_pkg.sh`:

```
#!/bin/bash
set -e

## SETUP ##
source scripts/pyrel/setup.inc.sh

## TEST ##
myprogram --version # just check the program runs and doesn't return error code

## TEAR DOWN ##
cd "$scriptParentDir"
source scripts/pyrel/teardown.inc.sh
```