#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COMMON_RULES_FILE="$SCRIPT_DIR/../AGENTS.md"
TARGET_DIR="${1:-$PWD}"
TARGET_FILE="$TARGET_DIR/AGENTS.md"

KARPATHY_URL="https://raw.githubusercontent.com/multica-ai/andrej-karpathy-skills/main/CLAUDE.md"
BEGIN_MARKER="<!-- BEGIN agent-guidelines -->"
END_MARKER="<!-- END agent-guidelines -->"

if [[ ! -f "$COMMON_RULES_FILE" ]]; then
  echo "Error: common rules not found at $COMMON_RULES_FILE" >&2
  exit 1
fi

# Step 1: Fetch Karpathy guidelines and update target AGENTS.md
echo "Fetching Karpathy guidelines from GitHub..."
KARPATHY_CONTENT=$(curl -fsSL "$KARPATHY_URL") || {
  echo "Error: failed to fetch Karpathy guidelines from $KARPATHY_URL" >&2
  exit 1
}

BLOCK_FILE=$(mktemp)
trap 'rm -f "$BLOCK_FILE"' EXIT

{
  echo "$BEGIN_MARKER"
  cat "$COMMON_RULES_FILE"
  echo ""
  echo "$KARPATHY_CONTENT"
  echo "$END_MARKER"
} > "$BLOCK_FILE"

if [[ ! -f "$TARGET_FILE" ]]; then
  cp "$BLOCK_FILE" "$TARGET_FILE"
  echo "Created $TARGET_FILE"
elif grep -qF "$BEGIN_MARKER" "$TARGET_FILE"; then
  begin_line=$(grep -nF "$BEGIN_MARKER" "$TARGET_FILE" | head -1 | cut -d: -f1)
  end_line=$(grep -nF "$END_MARKER" "$TARGET_FILE" | head -1 | cut -d: -f1)
  {
    [[ $begin_line -gt 1 ]] && head -n $((begin_line - 1)) "$TARGET_FILE"
    cat "$BLOCK_FILE"
    tail -n +$((end_line + 1)) "$TARGET_FILE"
  } > "$TARGET_FILE.tmp" && mv "$TARGET_FILE.tmp" "$TARGET_FILE"
  echo "Updated $TARGET_FILE (replaced existing block)"
else
  { printf '\n'; cat "$BLOCK_FILE"; } >> "$TARGET_FILE"
  echo "Updated $TARGET_FILE (appended block)"
fi

# Ensure CLAUDE.md exists and references AGENTS.md
CLAUDE_FILE="$TARGET_DIR/CLAUDE.md"
if [[ ! -f "$CLAUDE_FILE" ]]; then
  echo "@AGENTS.md" > "$CLAUDE_FILE"
  echo "Created $CLAUDE_FILE"
else
  claude_content=$(tr -d '[:space:]' < "$CLAUDE_FILE")
  if [[ "$claude_content" != "@AGENTS.md" ]]; then
    echo "ERROR: $CLAUDE_FILE must contain only '@AGENTS.md'." >&2
    echo "Migrate all content from CLAUDE.md to AGENTS.md, then replace CLAUDE.md with a single line: @AGENTS.md" >&2
    exit 1
  fi
  echo "$CLAUDE_FILE already references AGENTS.md, skipping"
fi

# Step 2 (from sync-external-repos.sh): Pull .claude/ if it is a git repo
CLAUDE_DIR="$TARGET_DIR/.claude"
if [[ -d "$CLAUDE_DIR/.git" ]]; then
  echo "Updating .claude (official skills)..."
  git -C "$CLAUDE_DIR" pull --ff-only
fi

echo "Done."
