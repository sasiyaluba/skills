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

link_agent_instructions() {
  agent_name=$1
  instructions_file=$2
  instructions_source=$repo_dir/AGENTS.md
  instructions_dir=${instructions_file%/*}

  if [ -L "$instructions_file" ] && [ "$(readlink "$instructions_file")" = "$instructions_source" ]; then
    printf 'Kept %s instructions link at %s\n' "$agent_name" "$instructions_file"
    return 0
  fi

  archive_directory "${agent_name}-instructions" "$instructions_file"
  mkdir -p "$instructions_dir"
  ln -s "$instructions_source" "$instructions_file"
  printf 'Linked %s instructions at %s\n' "$agent_name" "$instructions_file"
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

archive_shared_skill_roots() {
  archive_directory shared-agent-skills "$HOME/.agents/skills"
  archive_directory shared-web3-skills "$HOME/.agents/web3-skills"
}

make_web3_skill_user_invoked() {
  skill_dir=$1
  skill_name=${skill_dir##*/}
  skill_file=$skill_dir/SKILL.md
  openai_file=$skill_dir/agents/openai.yaml
  frontmatter_tmp=$tmp_dir/$skill_name.SKILL.md
  openai_tmp=$tmp_dir/$skill_name.openai.yaml

  if [ ! -f "$skill_file" ]; then
    printf 'Web3 skill definition not found: %s\n' "$skill_file" >&2
    exit 1
  fi

  awk '
    NR == 1 && $0 == "---" { in_frontmatter = 1; print; next }
    in_frontmatter && /^disable-model-invocation:/ {
      if (!seen_disable) print "disable-model-invocation: true"
      seen_disable = 1
      next
    }
    in_frontmatter && /^hide:/ {
      if (!seen_hide) print "hide: true"
      seen_hide = 1
      next
    }
    in_frontmatter && $0 == "---" {
      if (!seen_disable) print "disable-model-invocation: true"
      if (!seen_hide) print "hide: true"
      in_frontmatter = 0
    }
    { print }
  ' "$skill_file" > "$frontmatter_tmp"
  cat "$frontmatter_tmp" > "$skill_file"

  mkdir -p "$skill_dir/agents"
  if [ -f "$openai_file" ]; then
    awk '
      /^policy:[[:space:]]*$/ {
        seen_policy = 1
        in_policy = 1
        print
        next
      }
      in_policy && /^[^[:space:]#]/ {
        if (!seen_allow) print "  allow_implicit_invocation: false"
        in_policy = 0
      }
      in_policy && /^[[:space:]]+allow_implicit_invocation:/ {
        if (!seen_allow) print "  allow_implicit_invocation: false"
        seen_allow = 1
        next
      }
      { print }
      END {
        if (in_policy && !seen_allow) print "  allow_implicit_invocation: false"
        if (!seen_policy) {
          print "policy:"
          print "  allow_implicit_invocation: false"
        }
      }
    ' "$openai_file" > "$openai_tmp"
  else
    printf 'policy:\n  allow_implicit_invocation: false\n' > "$openai_tmp"
  fi
  cat "$openai_tmp" > "$openai_file"
}

migrate_legacy_omp_web3_directory() {
  config_file=$HOME/.omp/agent/config.yml
  legacy_dir=$HOME/.agents/web3-skills
  managed_dir=$repo_dir/web3-skills
  migrated_config=$tmp_dir/omp-config.yml


  [ -f "$config_file" ] || return 0

  awk -v legacy_dir="$legacy_dir" -v managed_dir="$managed_dir" '
    $0 == "    - " legacy_dir { print "    - " managed_dir; next }
    { print }
  ' "$config_file" > "$migrated_config"

  if ! cmp -s "$config_file" "$migrated_config"; then
    cat "$migrated_config" > "$config_file"
    printf 'Replaced legacy OMP Web3 skill directory with %s\n' "$managed_dir"
  fi
}

for skill_name in client-auditor contract-auditor exploit-investigator; do
  make_web3_skill_user_invoked "$repo_dir/web3-skills/$skill_name"
done
migrate_legacy_omp_web3_directory
archive_shared_skill_roots

: > "$skills_manifest"
for skill_root in \
  "$repo_dir/finding-writer" \
  "$repo_dir/finding-polisher" \
  "$repo_dir/code-audit" \
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
  instructions_file=$5

  if command -v "$executable" >/dev/null 2>&1 || [ -d "$agent_home" ]; then
    printf '%s|%s|%s\n' "$agent_name" "$skills_dir" "$instructions_file" >> "$agents_manifest"
  else
    printf 'Skipped %s: agent not installed\n' "$agent_name"
  fi
}

register_agent Codex codex "$HOME/.codex" "$HOME/.codex/skills" "$HOME/.codex/AGENTS.md"
register_agent OMP omp "$HOME/.omp" "$HOME/.omp/agent/skills" "$HOME/.omp/agent/AGENTS.md"
register_agent Pi pi "$HOME/.pi" "$HOME/.pi/agent/skills" "$HOME/.pi/agent/AGENTS.md"
register_agent "Claude Code" claude "$HOME/.claude" "$HOME/.claude/skills" "$HOME/.claude/CLAUDE.md"

if [ ! -s "$agents_manifest" ]; then
  printf 'No supported agents detected; nothing to install.\n'
  exit 0
fi

declared_name() {
  sed -n 's/^name:[[:space:]]*//p' "$1/SKILL.md" | sed -n '1p'
}

while IFS='|' read -r agent_name skills_dir instructions_file; do
  link_agent_instructions "$agent_name" "$instructions_file"
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
