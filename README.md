# pyrel [draft]

Reusable bash scrips that:

- build a package from the python module
- install a newly built package into a virtual environment
- let the user run the module
- delete all the temp files created

These files should not be executed directly (so they miss +x).

Lay code like that:

```
project
| myprogram/
| test_pkg/
| test_pkg.sh
```

Sample test_pkg.sh:

```
#!/bin/bash

## SETUP ##
source test_pkg/setup.inc.sh

## TEST ##
myprogram --version

## TEAR DOWN ##
cd "$scriptParentDir"
source test_pkg/teardown.inc.sh
```