#!/bin/bash
# ─────────────────────────────────────────────────────────────
# Scaffold Guard Hook
# Runs before Claude writes new files.
# Warns if a file is being created in an unusual location.
# ─────────────────────────────────────────────────────────────

YELLOW="\033[0;33m"
NC="\033[0m"

# Read the file path being written from env (Claude Code passes CLAUDE_TOOL_INPUT)
FILE_PATH="${CLAUDE_TOOL_INPUT_PATH:-}"

if [ -z "$FILE_PATH" ]; then
  exit 0  # No path to check
fi

# ── Warn on common wrong-location mistakes ────────────────────

# New component created outside components/
if [[ "$FILE_PATH" == *.tsx ]] && [[ "$FILE_PATH" != *components/* ]] && [[ "$FILE_PATH" != *pages/* ]] && [[ "$FILE_PATH" != *app/* ]]; then
  echo -e "${YELLOW}⚠ Warning: .tsx file outside components/, pages/, or app/: $FILE_PATH${NC}" >&2
fi

# Test file not in __tests__ or *.test.* pattern
if [[ "$FILE_PATH" == *test* ]] && [[ "$FILE_PATH" != *__tests__/* ]] && [[ "$FILE_PATH" != *.test.* ]] && [[ "$FILE_PATH" != *.spec.* ]]; then
  echo -e "${YELLOW}⚠ Warning: test file may be in wrong location: $FILE_PATH${NC}" >&2
fi

# Writing to node_modules (should never happen)
if [[ "$FILE_PATH" == *node_modules/* ]]; then
  echo "✗ Blocked: attempted write to node_modules/" >&2
  exit 1
fi

exit 0
