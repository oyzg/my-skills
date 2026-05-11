#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CODEX_HOME_DIR="${CODEX_HOME:-$HOME/.codex}"
DEST="$CODEX_HOME_DIR/skills"
FORCE=0
DRY_RUN=0

usage() {
  echo "Usage: $0 [--dry-run] [--force]"
  echo ""
  echo "Installs this repository's skills into:"
  echo "  ${CODEX_HOME:-$HOME/.codex}/skills"
  echo ""
  echo "Options:"
  echo "  --dry-run   Show what would be linked"
  echo "  --force     Replace existing non-symlink skill directories"
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    --dry-run)
      DRY_RUN=1
      ;;
    --force)
      FORCE=1
      ;;
    --help|-h)
      usage
      exit 0
      ;;
    *)
      echo "Unknown option: $1"
      usage
      exit 1
      ;;
  esac
  shift
done

mkdir -p "$DEST"

for skill_dir in "$REPO_ROOT"/skills/*/; do
  [ -d "$skill_dir" ] || continue
  category="$(basename "$skill_dir")"
  for inner_dir in "$skill_dir"*/; do
    [ -d "$inner_dir" ] || continue
    [ -f "$inner_dir/SKILL.md" ] || continue

    name="$(basename "$inner_dir")"
    mkdir -p "$DEST/$category"
    target="$DEST/$category/$name"

  if [ "$DRY_RUN" -eq 1 ]; then
    echo "would link $name -> $skill_dir"
    continue
  fi

  if [ -e "$target" ] || [ -L "$target" ]; then
    if [ -L "$target" ]; then
      rm -f "$target"
    elif [ "$FORCE" -eq 1 ]; then
      rm -rf "$target"
    else
      echo "Refusing to replace existing non-symlink skill: $target"
      echo "Use --force if you intentionally want to replace it."
      exit 1
    fi
  fi

  ln -s "$inner_dir" "$target"
  echo "linked $category/$name -> $inner_dir"
  done
done

echo "Restart Codex to pick up installed or refreshed skills."
echo ""
echo "For stable per-project routing, add this to the project's AGENTS.md:"
echo '  Before any coding task, read skills/TRIGGERS.md and follow the matched skill.'
