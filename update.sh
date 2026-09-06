#!/bin/sh
set -eu

repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

if git -C "$repo_dir" rev-parse --abbrev-ref '@{upstream}' >/dev/null 2>&1; then
  git -C "$repo_dir" pull --ff-only --recurse-submodules
else
  printf 'Skipped main repository pull: no upstream configured\n'
fi

git -C "$repo_dir" submodule update --init --recursive --remote
TAO_SKILLS_SKIP_SUBMODULE_UPDATE=1 "$repo_dir/install.sh"

printf 'All skill repositories are at their latest remote revisions.\n'
