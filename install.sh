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
backup_root=$HOME/.local/share/sasiyaluba-skills-backups/$(date +%Y%m%d-%H%M%S)-$$

for legacy_instructions in \
  "$HOME/.codex/AGENTS.md" \
  "$HOME/.omp/agent/AGENTS.md" \
  "$HOME/.pi/agent/AGENTS.md" \
  "$HOME/.claude/CLAUDE.md"
do
  if [ -L "$legacy_instructions" ] && [ "$(readlink "$legacy_instructions")" = "$repo_dir/AGENTS.md" ]; then
    rm "$legacy_instructions"
    printf 'Removed legacy instructions link %s\n' "$legacy_instructions"
  fi
done

archive_directory() {
  archive_label=$1
  archive_source=$2

  if [ ! -e "$archive_source" ] && [ ! -L "$archive_source" ]; then
    return 0
  fi

  mkdir -p "$backup_root"
  mv "$archive_source" "$backup_root/$archive_label"
  printf 'Archived %s at %s\n' "$archive_source" "$backup_root/$archive_label"
}

reset_exclusive_skills_directory() {
  agent_name=$1
  skills_dir=$2
  contains_regular_entry=0

  if [ -d "$skills_dir" ]; then
    for existing in "$skills_dir"/* "$skills_dir"/.[!.]* "$skills_dir"/..?*; do
      if { [ -e "$existing" ] || [ -L "$existing" ]; } && [ ! -L "$existing" ]; then
        contains_regular_entry=1
        break
      fi
    done

    if [ "$contains_regular_entry" -eq 1 ]; then
      archive_directory "${agent_name}-skills" "$skills_dir"
    else
      rm -rf "$skills_dir"
    fi
  elif [ -e "$skills_dir" ] || [ -L "$skills_dir" ]; then
    archive_directory "${agent_name}-skills" "$skills_dir"
  fi

  mkdir -p "$skills_dir"
}

: > "$skills_manifest"
for skill_root in \
  "$repo_dir/finding-writer" \
  "$repo_dir/code-audit" \
  "$repo_dir/socrates" \
  "$repo_dir/answer-me" \
  "$repo_dir/mattpocock-skills/skills"
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
register_agent OMP omp "$HOME/.omp" "$HOME/.omp/agent/skills"
register_agent Pi pi "$HOME/.pi" "$HOME/.pi/agent/skills"
register_agent "Claude Code" claude "$HOME/.claude" "$HOME/.claude/skills"

if [ ! -s "$agents_manifest" ]; then
  printf 'No supported agents detected; nothing to install.\n'
  exit 0
fi

declared_name() {
  sed -n 's/^name:[[:space:]]*//p' "$1/SKILL.md" | sed -n '1p'
}

while IFS='|' read -r agent_name skills_dir; do
  case "$agent_name" in
    Codex|OMP|Pi) reset_exclusive_skills_directory "$agent_name" "$skills_dir" ;;
    *) mkdir -p "$skills_dir" ;;
  esac
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
