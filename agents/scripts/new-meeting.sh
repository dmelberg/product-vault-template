#!/usr/bin/env bash
# new-meeting.sh — scaffold a meeting note from templates/meeting-notes.md
# Usage:
#   new-meeting.sh <slug> [--project YYYY-MM-<slug>] [--date YYYY-MM-DD]
# With --project, the note lands in that project's meetings/ folder and is
# pre-linked to it (feeds:). Without it, the note goes to the vault-level
# meetings/ inbox to be linked into a project later.
set -euo pipefail

VAULT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TEMPLATES_DIR="$VAULT_ROOT/templates"
PROJECTS_DIR="$VAULT_ROOT/projects"

USAGE="Usage: new-meeting.sh <slug> [--project YYYY-MM-<slug>] [--date YYYY-MM-DD]"

SLUG=""
PROJECT=""
MEET_DATE="$(date +%Y-%m-%d)"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --project) PROJECT="$2";   shift 2 ;;
    --date)    MEET_DATE="$2"; shift 2 ;;
    -*) echo "Unknown option: $1" >&2; echo "$USAGE" >&2; exit 1 ;;
    *)  if [[ -z "$SLUG" ]]; then SLUG="$1"; else echo "Unexpected argument: $1" >&2; exit 1; fi; shift ;;
  esac
done

if [[ -z "$SLUG" ]]; then
  echo "Error: slug is required." >&2
  echo "$USAGE" >&2
  exit 1
fi

TITLE="$(echo "$SLUG" | sed 's/-/ /g' | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) substr($i,2)} 1')"

if [[ -n "$PROJECT" ]]; then
  DEST_DIR="$PROJECTS_DIR/$PROJECT/meetings"
  if [[ ! -d "$PROJECTS_DIR/$PROJECT" ]]; then
    echo "Error: project not found: $PROJECTS_DIR/$PROJECT" >&2
    exit 1
  fi
  FEEDS="[[$PROJECT]]"
else
  DEST_DIR="$VAULT_ROOT/meetings"
  FEEDS=""
fi

mkdir -p "$DEST_DIR"
TARGET="$DEST_DIR/${MEET_DATE}-${SLUG}.md"
if [[ -f "$TARGET" ]]; then
  echo "Error: meeting note already exists: $TARGET" >&2
  exit 1
fi

sed -e "s/{{title}}/$TITLE/g" -e "s/{{date}}/$MEET_DATE/g" "$TEMPLATES_DIR/meeting-notes.md" > "$TARGET"
sed -i '' -e "s|^feeds: \"\"|feeds: \"$FEEDS\"|" "$TARGET"

echo ""
echo "  Meeting note created: $TARGET"
[[ -n "$FEEDS" ]] && echo "  Linked to project: $FEEDS"
echo ""
