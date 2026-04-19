# claude-base

> A portable `.claude/` starter that auto-configures itself for any project stack.

## How it works

```
bootstrap.sh          ← copies base .claude/ into your project
    └── /init-project ← Claude reads your stack, generates everything custom
    └── /sync-claude  ← re-runs when stack changes
```

## Setup (any new project)

```bash
# Option A: curl one-liner
curl -s https://raw.githubusercontent.com/ankursoni-dev/claude-base/main/bootstrap.sh | bash

# Option B: clone and copy
git clone https://github.com/ankursoni-dev/claude-base.git /tmp/claude-base
cp -r /tmp/claude-base/.claude ./.claude

# Then inside Claude Code:
claude "/init-project"
```

That's it. Claude will:
1. Detect your framework, language, test runner, linter, deploy target
2. Generate project-specific agents, commands, hooks, rules
3. Write a populated `CLAUDE.md` with your actual stack

## What ships in base (stack-agnostic)

| File | Purpose |
|------|---------|
| `commands/init-project.md` | Generates everything custom |
| `commands/sync-claude.md` | Re-generates when stack changes |
| `agents/debugger.md` | Root-cause debugging |
| `agents/doc-writer.md` | README + inline docs |
| `hooks/scaffold-guard.sh` | Warns on wrong-location file writes |
| `rules/general.md` | Universal guardrails |
| `settings.json` | Safe defaults (no .env, no force push) |
| `CLAUDE.md` | Template — filled by init-project |

## What `/init-project` generates for you

**agents/** — tailored to your stack:
- `code-reviewer.md` — knows your linter, test framework, security patterns
- `test-writer.md` — uses Vitest / Jest / Pytest / etc.
- `db-migrator.md` — if you have Prisma / Drizzle / Alembic
- + more based on what it finds

**commands/** — your actual scripts:
- `deploy.md` — Vercel / Railway / Fly / Docker — whichever you use
- `test.md` — your exact test command with coverage
- `lint.md` — your linter + formatter combination
- + more based on your `package.json` scripts

**hooks/** — using your tools:
- `pre-commit.sh` — TypeScript check + your linter + your tests
- `lint-on-save.sh` — Prettier / Biome / Ruff — whichever applies

**rules/** — scoped to your folders:
- `api.md` — scoped to your actual API route paths
- `database.md` — scoped to your migrations folder
- `frontend.md` — scoped to your components folder

## When to re-run

```bash
# Stack changed significantly (new DB, new deploy target, etc.)
claude "/sync-claude"
```

## Updating the base

To pull latest base files without losing your custom files:
```bash
curl -s https://raw.githubusercontent.com/ankursoni-dev/claude-base/main/.claude/rules/general.md \
  -o .claude/rules/general.md
# repeat for other base files you want to update
```
