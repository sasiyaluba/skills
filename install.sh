#!/bin/sh
set -eu

repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

if [ "${TAO_SKILLS_SKIP_SUBMODULE_UPDATE:-0}" != "1" ]; then
  git -C "$repo_dir" submodule update --init --recursive
fi

tmp_dir=$(mktemp -d "${TMPDIR:-/tmp}/tao-skills.XXXXXX")
trap 'rm -rf "$tmp_dir"' EXIT HUP INT TERM
skills_manifest="$tmp_dir/skills"
agents_manifest="$tmp_dir/agents"

: > "$skills_manifest"
for skill_root in \
  "$repo_dir/finding-writer" \
  "$repo_dir/mattpocock-skills/skills" \
  "$repo_dir/web3-skills" \
  "$repo_dir/thinking-partner/skills"
do
  if [ ! -d "$skill_root" ]; then
    printf 'Skill source not found: %s\n' "$skill_root" >&2
    exit 1
  fi
  find "$skill_root" -type f -name SKILL.md -print >> "$skills_manifest"
done
LC_ALL=C sort -o "$skills_manifest" "$skills_manifest"

if [ ! -s "$skills_manifest" ]; then
  printf 'No skills found in %s\n' "$repo_dir" >&2
  exit 1
fi

seen='|'
while IFS= read -r skill_file; do
  skill_dir=${skill_file%/SKILL.md}
  skill_name=${skill_dir##*/}
  case "$seen" in
    *"|$skill_name|"*)
      printf 'Duplicate skill name: %s\n' "$skill_name" >&2
      exit 1
      ;;
  esac
  seen="${seen}${skill_name}|"
done < "$skills_manifest"

: > "$agents_manifest"
register_agent() {
  agent_name=$1
  executable=$2
  agent_home=$3
  skills_dir=$4

  if command -v "$executable" >/dev/null 2>&1 || [ -d "$agent_home" ]; then
    printf '%s|%s\n' "$agent_name" "$skills_dir" >> "$agents_manifest"
  else
    printf 'Skipped %s: agent not installed\n' "$agent_name"
  fi
}

register_agent Codex codex "$HOME/.codex" "$HOME/.codex/skills"
register_agent Claude claude "$HOME/.claude" "$HOME/.claude/skills"
register_agent OMP omp "$HOME/.omp" "$HOME/.omp/agent/skills"
register_agent Pi pi "$HOME/.pi" "$HOME/.pi/agent/skills"

if [ ! -s "$agents_manifest" ]; then
  printf 'No supported agents detected; nothing to install.\n'
  exit 0
fi

declared_name() {
  sed -n 's/^name:[[:space:]]*//p' "$1/SKILL.md" | sed -n '1p'
}

while IFS='|' read -r agent_name skills_dir; do
  mkdir -p "$skills_dir"
  installed=0

  while IFS= read -r skill_file; do
    skill_source=${skill_file%/SKILL.md}
    skill_name=${skill_source##*/}
    target="$skills_dir/$skill_name"

    if [ -e "$target" ] && [ ! -L "$target" ]; then
      printf 'Kept %s: existing path is not a symlink\n' "$target"
      continue
    fi

    # Remove older symlink names that expose the same declared skill.
    for existing in "$skills_dir"/*; do
      [ "$existing" = "$target" ] && continue
      [ -L "$existing" ] || continue
      [ -f "$existing/SKILL.md" ] || continue
      if [ "$(declared_name "$existing")" = "$skill_name" ]; then
        rm "$existing"
        printf 'Removed duplicate link %s\n' "$existing"
      fi
    done

    if [ -L "$target" ]; then
      rm "$target"
    fi
    ln -s "$skill_source" "$target"
    installed=$((installed + 1))
  done < "$skills_manifest"

  # Remove broken links previously managed from this repository.
  for existing in "$skills_dir"/*; do
    [ -L "$existing" ] || continue
    link_source=$(readlink "$existing")
    case "$link_source" in
      "$repo_dir"/*)
        if [ ! -f "$existing/SKILL.md" ]; then
          rm "$existing"
          printf 'Removed stale link %s\n' "$existing"
        fi
        ;;
    esac
  done

  printf 'Installed %s skills for %s in %s\n' "$installed" "$agent_name" "$skills_dir"
done < "$agents_manifest"

# Make ordinary pulls recurse into the checked-out skill repositories.
git -C "$repo_dir" config submodule.recurse true
