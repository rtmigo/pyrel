#!/bin/bash

# SPDX-FileCopyrightText: (c) 2021 Art Galkin <ortemeo@gmail.com>
# SPDX-License-Identifier: BSD-3-Clause

# check that all we deactivate and remove all those venvs

set -e

source "${0%/*}/../pyrel.sh"

set -e
trap_insert 'echo "in trap A"' EXIT
trap_insert 'echo "in trap B"' EXIT
echo "before error"
run_bad_command
echo "after error"
