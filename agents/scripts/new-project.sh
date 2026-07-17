#!/usr/bin/env bash
# new-project.sh — scaffold a new product vault project
# Usage:
#   new-project.sh <slug> [--type spec|research|roadmap-review|strategy]
#                         [--tickets FIN-1,FIN-2] [--linear URL] [--notion URL]
# Defaults to --type spec.
set -euo pipefail

VAULT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PROJECTS_DIR="$VAULT_ROOT/projects"
TEMPLATES_DIR="$VAULT_ROOT/templates"
TODAY="$(date +%Y-%m)"
FULL_DATE="$(date +%Y-%m-%d)"

USAGE="Usage: new-project.sh <slug> [--type spec|research|roadmap-review|strategy] [--tickets FIN-1,FIN-2] [--linear URL] [--notion URL]"

# ── argument parsing ─────────────────────────────────────────────────────────
SLUG=""
TYPE="spec"
TICKETS=""
LINEAR=""
NOTION=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --type)    TYPE="$2";    shift 2 ;;
    --tickets) TICKETS="$2"; shift 2 ;;
    --linear)  LINEAR="$2";  shift 2 ;;
    --notion)  NOTION="$2";  shift 2 ;;
    -*)
      echo "Unknown option: $1" >&2
      echo "$USAGE" >&2
      exit 1
      ;;
    *)
      if [[ -z "$SLUG" ]]; then
        SLUG="$1"
      else
        echo "Unexpected argument: $1" >&2
        exit 1
      fi
      shift
      ;;
  esac
done

if [[ -z "$SLUG" ]]; then
  echo "Error: slug is required." >&2
  echo "$USAGE" >&2
  exit 1
fi

# ── map type → subfolders + deliverable template ─────────────────────────────
case "$TYPE" in
  spec)
    SUBFOLDERS=(research meetings decisions documents)
    DELIVERABLE_TEMPLATE="product-spec.md"
    DELIVERABLE_FILE="${SLUG}-spec.md" ;;
  research)
    SUBFOLDERS=(meetings documents)
    DELIVERABLE_TEMPLATE="research.md"
    DELIVERABLE_FILE="${SLUG}-research.md" ;;
  roadmap-review)
    SUBFOLDERS=(meetings documents)
    DELIVERABLE_TEMPLATE="roadmap-review.md"
    DELIVERABLE_FILE="${SLUG}-roadmap-review.md" ;;
  strategy)
    SUBFOLDERS=(research meetings documents)
    DELIVERABLE_TEMPLATE="strategy.md"
    DELIVERABLE_FILE="${SLUG}-strategy.md" ;;
  *)
    echo "Error: unknown --type '$TYPE'. Use spec|research|roadmap-review|strategy." >&2
    exit 1 ;;
esac

# ── derive folder name ───────────────────────────────────────────────────────
DIR_NAME="${TODAY}-${SLUG}"
PROJECT_DIR="$PROJECTS_DIR/$DIR_NAME"

if [[ -d "$PROJECT_DIR" ]]; then
  echo "Error: project already exists at $PROJECT_DIR" >&2
  exit 1
fi

# ── build YAML ticket list ───────────────────────────────────────────────────
if [[ -n "$TICKETS" ]]; then
  TICKET_LIST="["
  IFS=',' read -ra IDS <<< "$TICKETS"
  for ID in "${IDS[@]}"; do
    TICKET_LIST+="$ID, "
  done
  TICKET_LIST="${TICKET_LIST%, }]"
else
  TICKET_LIST="[]"
fi

TITLE="$(echo "$SLUG" | sed 's/-/ /g' | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) substr($i,2)} 1')"

# ── helper: instantiate a template with title/date substitution ──────────────
render() {  # render <template-name> <target-path>
  sed -e "s/{{title}}/$TITLE/g" -e "s/{{date}}/$FULL_DATE/g" "$TEMPLATES_DIR/$1" > "$2"
}

# ── create structure ─────────────────────────────────────────────────────────
mkdir -p "$PROJECT_DIR"
for f in "${SUBFOLDERS[@]}"; do mkdir -p "$PROJECT_DIR/$f"; done

# ── project.md (overview) ────────────────────────────────────────────────────
TARGET="$PROJECT_DIR/project.md"
render "project.md" "$TARGET"
sed -i '' \
  -e "s/^project_type: spec.*/project_type: $TYPE/" \
  -e "s/^tickets: \[\]/tickets: $TICKET_LIST/" \
  -e "s|^linear_project: \"\"|linear_project: \"$LINEAR\"|" \
  -e "s|^notion_url: \"\"|notion_url: \"$NOTION\"|" \
  "$TARGET"

# link the deliverable from project.md
DELIVERABLE_SLUG="${DELIVERABLE_FILE%.md}"
sed -i '' -e "s|^- \[\[ \]\]|- [[$DELIVERABLE_SLUG]]|" "$TARGET"

# ── deliverable (spec / research / roadmap-review / strategy) ─────────────────
render "$DELIVERABLE_TEMPLATE" "$PROJECT_DIR/$DELIVERABLE_FILE"

# ── done ─────────────────────────────────────────────────────────────────────
echo ""
echo "  Project created: $PROJECT_DIR  (type: $TYPE)"
echo ""
echo "  Files:"
echo "    project.md              — overview + frontmatter"
echo "    $DELIVERABLE_FILE — the deliverable (edit here, then mirror to Notion)"
echo ""
echo "  Subfolders: ${SUBFOLDERS[*]}"
echo "    (copy + rename templates/ notes into them — meeting-notes.md, decision.md, research.md, plan.md)"
echo ""
