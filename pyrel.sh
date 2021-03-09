# SPDX-FileCopyrightText: (c) 2021 Art Galkin <ortemeo@gmail.com>
# SPDX-License-Identifier: BSD-3-Clause

if [ ! -f "./setup.py" ]; then
  echo "./setup.py not found. Please run the script python project directory"
  return 1
fi

echo "OK, we're in the project root"

project_root_dir=$(realpath .)

function begin_venv() {
  temp_venv_dir=$(mktemp -d -t venv)
  python3 -m venv "$temp_venv_dir"
  # shellcheck disable=SC1090
  source "$temp_venv_dir/bin/activate"
}

function end_venv() {
  deactivate
  python3 -m venv "$temp_venv_dir" --clear
  rm -rf "$temp_venv_dir"
}

function build_package() {
  cd "$project_root_dir" || return 1
  python3 -m pip install --upgrade pip
  pip3 install setuptools wheel twine --force-reinstall
  python3 setup.py sdist bdist_wheel
}

function check_package() {
  cd "$project_root_dir" || return 1
  twine check ./dist/* --strict
}

function find_latest_file() {
  # usage: find_latest_file *.txt
  local file
  local latest_file
  for file in $1; do
    [[ $file -nt latest_file ]] && latest_file=$file
  done
  echo "$latest_file"
}

function install_package_from_latest_whl() {
  local latest_whl_file
  latest_whl_file=$(find_latest_file "$project_root_dir"/dist/*.whl)
  pip3 install "$latest_whl_file" --force-reinstall
}

function package_test_setup() {

  echo "== BUILDING PACKAGE =="
  begin_venv
  build_package
  check_package
  end_venv

  echo "== INSTALLING PACKAGE =="
  begin_runner_venv
  install_package_from_latest_whl

  # move from the current directory to random one
  nowhere_dir=$(mktemp -d -t ci-XXXXXXXXXX)
  cd "$nowhere_dir" || return 1

  echo "== RUNNING =="
}

function package_test_teardown() {

  echo "== REMOVING TEMP AND DIST FILES =="

  # Python 3.7 sometimes fails when trying to --clear venv while the current
  # directory is created by mktemp. That's why we move to the project before
  # ending the venv
  cd "$project_root_dir" || return 1
  end_runner_venv
  rm -rf "$nowhere_dir"
  echo "All done."
}

function remove_dist() {
  cd "$project_root_dir" || return 1
  rm -rf ./build ./dist ./*.egg-info
}
