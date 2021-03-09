#!/bin/bash

# SPDX-FileCopyrightText: (c) 2021 Art Galkin <ortemeo@gmail.com>
# SPDX-License-Identifier: BSD-3-Clause

set -e

source "${0%/*}/../pyrel.sh"

echo "START"

pyrel_venv_begin
echo "INSIDE VENV 1"
pyrel_venv_begin
echo "INSIDE VENV 2"

# expected output:
#   INSIDE VENV 1
#   removing <temp venv>
#   removed <temp venv>
#
# So we failed the create a nested venv, but done cleanup anyway