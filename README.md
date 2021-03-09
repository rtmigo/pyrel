# pyrel

Bash functions for building and testing Python packages.

# Install

`pyrel.sh` is just a small script file meant to be included when you're at the project root:

```bash
cd /abc/myproject
source path/to/pyrel.sh
```

You can also automate copying the latest version to `/abc/myproject/scripts/pyrel/`.

<details><summary>If you prefer SVN</summary><br/>

Create `/abc/pythonproject/scripts/pyrel`:

```bash
$ cd /abc/pythonproject
$ svn export https://github.com/rtmigo/pyrel/trunk scripts/pyrel --force
```

Update with the same command.

</details>


<details><summary>If you prefer GIT subtrees</summary><br/>

Create `/abc/pythonproject/scripts/pyrel`:

```bash
$ cd /abc/pythonproject
$ git subtree add --prefix scripts/pyrel https://github.com/rtmigo/pyrel master --squash
```

Update to latest version:
```bash
$ cd /abc/pythonproject
$ git subtree pull -m "update pyrel" --prefix scripts/pyrel https://github.com/rtmigo/pyrel master --squash
```

</details>

<details><summary>If you prefer GIT submodules</summary><br/>

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

Remove if you change your mind:

```bash
$ cd /abc/pythonproject
$ git rm scripts/pyrel -f
$ rm -rf .git/modules/scripts/pyrel
```
</details>



# Use

The expected project layout is something like that:

```
pythonproject
| use_pyrel.sh        # user-created scripts
| use_pyrel_again.sh  # user-created scripts
| 
| scripts/pyrel/      # pyrel installed here
|
| myprogram/          # python standard project layout
| tests/              # python standard project layout
| setup.py            # python standard project layout
```


# Test a command-line utility package 

```bash
#!/bin/bash
set -e && source "${0%/*}/scripts/pyrel/pyrel.sh"

package_test_setup

myprogram --help
myprogram --version

package_test_teardown
```

- **pyrel**: builds a package from the python module
- **pyrel**: installs the newly built package into a virtual environment
- **user**: calls the program by name (so we'll know it is added to path)
- **user**: optionally runs it again (so we'll know the program ends without error code)
- **pyrel**: deletes all the temp files created
