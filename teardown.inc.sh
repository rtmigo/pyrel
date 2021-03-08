echo "== TEARING DOWN =="

rm -rf "$tmp_other_dir"
cd "$script_parent_dir"
deactivate
python3 -m venv "$tmp_runner_venv_dir" --clear
rm -rf "$tmp_runner_venv_dir"
rm -rf ./build ./dist ./*.egg-info
