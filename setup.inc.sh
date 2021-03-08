set -e

script_parent_dir="$(dirname "$(perl -MCwd -e 'print Cwd::abs_path shift' "$0")")"
cd "$script_parent_dir"

echo "== BUILDING IN VIRTUAL ENV =="

tmp_builder_venv_dir=$(mktemp -d -t ci-XXXXXXXXXX)
python3 -m venv "$tmp_builder_venv_dir"
# shellcheck disable=SC1090
source "$tmp_builder_venv_dir/bin/activate"
python3 -m pip install --upgrade pip
pip3 install setuptools wheel twine --force-reinstall
python3 setup.py sdist bdist_wheel
twine check ./dist/* --strict
deactivate
python3 -m venv "$tmp_builder_venv_dir" --clear
rm -rf "$tmp_builder_venv_dir"

echo "== CREATING RUNNER VIRTUAL ENV =="

tmp_runner_venv_dir=$(mktemp -d -t ci-XXXXXXXXXX)
python3 -m venv "$tmp_runner_venv_dir"
# shellcheck disable=SC1090
source "$tmp_runner_venv_dir/bin/activate"
python3 -m pip install --upgrade pip

echo "== INSTALLING PACKAGE FROM FILE =="

unset -v latest_whl_file
for file in ./dist/*.whl; do
  [[ $file -nt latest_whl_file ]] && latest_whl_file=$file
done

pip3 install "$latest_whl_file" --force-reinstall

echo "== RUNNING INSTALLED PACKAGE =="

tmp_other_dir=$(mktemp -d -t ci-XXXXXXXXXX)
cd "$tmp_other_dir"
