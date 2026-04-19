#!/bin/bash
# ─────────────────────────────────────────────────────────────
# Claude Code Bootstrap
# Usage: curl -s https://raw.githubusercontent.com/ankursoni-dev/claude-base/main/bootstrap.sh | bash
# Or:    bash bootstrap.sh
# ─────────────────────────────────────────────────────────────

set -e

REPO="https://raw.githubusercontent.com/ankursoni-dev/claude-base/master"
GREEN="\033[0;32m"
BLUE="\033[0;34m"
NC="\033[0m"

echo -e "${BLUE}▶ Claude Code Bootstrap${NC}"

# ── 1. Download base .claude folder ───────────────────────────
echo "  Downloading base .claude structure..."

mkdir -p .claude/{agents,commands,hooks,rules,skills/general}

files=(
  ".claude/settings.json"
  ".claude/CLAUDE.md"
  ".claude/commands/init-project.md"
  ".claude/commands/sync-claude.md"
  ".claude/agents/debugger.md"
  ".claude/agents/doc-writer.md"
  ".claude/hooks/scaffold-guard.sh"
  ".claude/rules/general.md"
  ".claude/skills/general/SKILL.md"
)

for f in "${files[@]}"; do
  curl -sf "$REPO/$f" -o "$f" 2>/dev/null || echo "  ⚠ Could not fetch $f (skipping)"
done

chmod +x .claude/hooks/*.sh 2>/dev/null || true

echo -e "${GREEN}  ✓ Base .claude folder ready${NC}"

# ── 2. Trigger project-specific generation ────────────────────
echo ""
echo -e "${BLUE}▶ Generating project-specific config via Claude Code...${NC}"
echo "  Run this next:"
echo ""
echo -e "  ${GREEN}claude \"/init-project\"${NC}"
echo ""
echo "  Claude will read your stack and auto-generate:"
echo "  • agents/   — reviewers, testers, debuggers for your stack"
echo "  • commands/ — deploy, test, pr-review for your toolchain"  
echo "  • hooks/    — pre-commit, lint-on-save for your linter/formatter"
echo "  • rules/    — guardrails scoped to your file patterns"
echo "  • CLAUDE.md — project brain seeded from your package.json"
