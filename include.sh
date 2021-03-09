# SPDX-FileCopyrightText: (c) 2021 Art Galkin <ortemeo@gmail.com>
# SPDX-License-Identifier: BSD-3-Clause

set -e

project_root_dir="${0%/*}" # this file is included from the script at root dir
cd "$project_root_dir"

function begin_builder_venv() {
  tmp_builder_venv_dir=$(mktemp -d -t ci-XXXXXXXXXX)
  python3 -m venv "$tmp_builder_venv_dir"
  # shellcheck disable=SC1090
  source "$tmp_builder_venv_dir/bin/activate"
}

function end_builder_venv() {
  deactivate
  python3 -m venv "$tmp_builder_venv_dir" --clear
  rm -rf "$tmp_builder_venv_dir"
}

function build_package_and_check() {
  python3 -m pip install --upgrade pip
  pip3 install setuptools wheel twine --force-reinstall
  python3 setup.py sdist bdist_wheel
  twine check ./dist/* --strict
}

function install_package_from_latest_whl() {
  unset -v latest_whl_file
  for file in ./dist/*.whl; do
    [[ $file -nt latest_whl_file ]] && latest_whl_file=$file
  done
  pip3 install "$latest_whl_file" --force-reinstall
}

function begin_runner_venv() {
  tmp_runner_venv_dir=$(mktemp -d -t ci-XXXXXXXXXX)
  python3 -m venv "$tmp_runner_venv_dir"
  # shellcheck disable=SC1090
  source "$tmp_runner_venv_dir/bin/activate"
  python3 -m pip install --upgrade pip
}

function end_runner_venv() {
  deactivate
  python3 -m venv "$tmp_runner_venv_dir" --clear
  rm -rf "$tmp_runner_venv_dir"
}

function package_test_setup() {

  echo "== BUILDING PACKAGE =="
  begin_builder_venv
  build_package_and_check
  end_builder_venv

  echo "== INSTALLING PACKAGE =="
  begin_runner_venv
  install_package_from_latest_whl

  pwd_before_package_test=$(pwd)

  # change directory to random anywhere to check
  # the module really added to path
  tmp_runner_dir=$(mktemp -d -t ci-XXXXXXXXXX)
  cd "$tmp_runner_dir"

  echo "== RUNNING =="
}

function package_test_teardown() {
  cd "$pwd_before_package_test"
  echo "== REMOVING TEMP AND DIST FILES =="
  rm -rf "$tmp_runner_dir"
  rm -rf ./build ./dist ./*.egg-info
  end_runner_venv
  echo "All done."
}
