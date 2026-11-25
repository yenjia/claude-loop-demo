#!/bin/sh
# 還原到起始狀態：只留下資料、說明、授權與 requirements（.venv 與 .git 保留）
# Restore the starting state: keep data, docs, license and requirements (.venv and .git are kept)
cd "$(dirname "$0")" || exit 1
find . -mindepth 1 -maxdepth 1 \
  ! -name data ! -name README.md ! -name README.en.md ! -name LICENSE \
  ! -name requirements.txt ! -name reset.sh ! -name .gitignore \
  ! -name .venv ! -name .git -exec rm -rf {} +
find data -mindepth 1 ! -name train.npz ! -name val.npz ! -name README.md -exec rm -rf {} +
echo "reset ok"
