#!/bin/sh
set -eu

repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
tmp_dir=''

cleanup() {
  if [ -n "$tmp_dir" ] && [ -d "$tmp_dir" ]; then
    rm -rf "$tmp_dir"
  fi
}
trap cleanup EXIT HUP INT TERM

if git -C "$repo_dir" rev-parse --abbrev-ref '@{upstream}' >/dev/null 2>&1; then
  git -C "$repo_dir" pull --ff-only --recurse-submodules
else
  printf 'Skipped main repository pull: no upstream configured\n'
fi

git -C "$repo_dir" submodule update --init --recursive --remote

tmp_dir=$(mktemp -d "$repo_dir/.web3-skills-update.XXXXXX")
checkout="$tmp_dir/checkout"
vendored="$tmp_dir/vendored"
fork_url="git@github.com:sasiyaluba/web3-skills.git"
upstream_url="https://github.com/DarkNavySecurity/web3-skills.git"

git clone "$fork_url" "$checkout"
git -C "$checkout" remote add upstream "$upstream_url"
git -C "$checkout" fetch upstream main

if ! git -C "$checkout" merge-base --is-ancestor upstream/main HEAD; then
  if ! git -C "$checkout" merge --no-edit upstream/main; then
    preserved_checkout=$tmp_dir
    tmp_dir=''
    printf 'Web3 fork merge conflicted; resolve it in %s/checkout\n' "$preserved_checkout" >&2
    exit 1
  fi
  git -C "$checkout" push origin main
fi

mkdir "$vendored"
for skill_name in client-auditor contract-auditor exploit-investigator; do
  cp -R "$checkout/$skill_name" "$vendored/$skill_name"
done
cp "$checkout/LICENSE" "$vendored/LICENSE"
git -C "$checkout" rev-parse HEAD > "$vendored/.fork-commit"
git -C "$checkout" rev-parse upstream/main > "$vendored/.upstream-commit"

rm -rf "$repo_dir/web3-skills"
mv "$vendored" "$repo_dir/web3-skills"

TAO_SKILLS_SKIP_SUBMODULE_UPDATE=1 "$repo_dir/install.sh"

printf 'Submodules and vendored Web3 skills are at their latest remote revisions.\n'
