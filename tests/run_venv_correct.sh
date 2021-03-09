#!/bin/bash

# SPDX-FileCopyrightText: (c) 2021 Art Galkin <ortemeo@gmail.com>
# SPDX-License-Identifier: BSD-3-Clause


set -e

source "${0%/*}/../pyrel.sh"

echo "START"

pyrel_venv_begin
echo "INSIDE VENV 1"
pyrel_venv_end

pyrel_venv_begin
echo "INSIDE VENV 2"
pyrel_venv_end