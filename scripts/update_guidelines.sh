#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GUIDELINES_FILE="$SCRIPT_DIR/../CLAUDE.md"
TARGET_DIR="${1:-$PWD}"

BEGIN_MARKER="<!-- BEGIN agent-guidelines -->"
END_MARKER="<!-- END agent-guidelines -->"

if [[ ! -f "$GUIDELINES_FILE" ]]; then
  echo "Error: guidelines source not found at $GUIDELINES_FILE" >&2
  exit 1
fi

apply_to_file() {
  local file="$1"

  if [[ ! -f "$file" ]]; then
    cp "$GUIDELINES_FILE" "$file"
    echo "Created $file"
    return
  fi

  if grep -qF "$BEGIN_MARKER" "$file"; then
    local begin_line end_line
    begin_line=$(grep -nF "$BEGIN_MARKER" "$file" | head -1 | cut -d: -f1)
    end_line=$(grep -nF "$END_MARKER" "$file" | head -1 | cut -d: -f1)
    {
      [[ $begin_line -gt 1 ]] && head -n $((begin_line - 1)) "$file"
      cat "$GUIDELINES_FILE"
      tail -n +$((end_line + 1)) "$file"
    } > "$file.tmp" && mv "$file.tmp" "$file"
    echo "Updated $file (replaced existing block)"
  else
    { printf '\n'; cat "$GUIDELINES_FILE"; } >> "$file"
    echo "Updated $file (appended block)"
  fi
}

apply_to_file "$TARGET_DIR/CLAUDE.md"
apply_to_file "$TARGET_DIR/AGENTS.md"
