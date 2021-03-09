# pyrel

Bash scripts for building and testing Python packages.

Testing a package for command-line program:
- [pyrel] builds a package from the python module
- [pyrel] installs the newly built package into a virtual environment
- [user] calls the program by name (so we'll know it is added to path)
- [user] optionally runs it again (so we'll know the program ends without error code)
- [pyrel] deletes all the temp files created

# Install

The `pyrel` files are not installed on the system. They are **placed in the project directory**. This allows, for example, 
using them with GitHub actions.

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

No one should be judged by their tastes!?

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

<details><summary>If you prefer SVN</summary><br/>

Create `/abc/pythonproject/scripts/pyrel`:

```bash
$ cd /abc/pythonproject
$ svn export https://github.com/rtmigo/pyrel/trunk scripts/pyrel --force
```

Update with the same command.

</details>


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

```bash
#!/bin/bash
set -e && cd "${0%/*}"
source scripts/pyrel/include.sh
package_test_setup

myprogram --help

package_test_teardown
```