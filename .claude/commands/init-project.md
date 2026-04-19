---
name: init-project
description: Reads your project stack and generates all custom .claude files (agents, commands, hooks, rules, CLAUDE.md)
disable-model-invocation: false
---

You are a Claude Code configuration expert. Your job is to analyze this project and generate a complete, production-ready `.claude/` setup tailored to its exact stack.

## Step 1: Read the project

Run these to understand the project:
- `cat package.json` (or `pyproject.toml` / `Cargo.toml` / `go.mod` if not Node)
- `ls -la` to see top-level structure
- `cat README.md 2>/dev/null || echo "no readme"` 
- `git log --oneline -5 2>/dev/null || echo "no git history"`
- `ls src/ app/ lib/ 2>/dev/null || echo "check structure"`

## Step 2: Detect the stack

From what you read, identify:
- **Framework**: Next.js / Remix / Vite / Express / FastAPI / Django / Rails / etc.
- **Language**: TypeScript / JavaScript / Python / Rust / Go
- **Database**: Postgres / Supabase / Prisma / MongoDB / etc.
- **Auth**: NextAuth / Clerk / Supabase Auth / Auth0 / etc.
- **Styling**: Tailwind / CSS Modules / Styled Components / etc.
- **Testing**: Vitest / Jest / Pytest / Playwright / Cypress
- **Linter/Formatter**: ESLint / Prettier / Biome / Ruff / etc.
- **Deployment**: Vercel / Railway / Fly.io / AWS / Docker
- **Payment / Key APIs**: Stripe / Resend / OpenAI / etc.

## Step 3: Generate all files

Generate EVERY file below. Do not skip any. Write each file with `Write` tool.

---

### CLAUDE.md (project brain)

Write `.claude/CLAUDE.md`:

```
# CLAUDE.md — Project Brain

## Tech Stack
[list every detected technology with its purpose]

## Folder Structure  
[map actual folders to their purpose]

## Dev Commands
[actual npm/yarn/pnpm/python commands to run dev, build, test, lint]

## Coding Conventions
[infer from existing code: naming, component style, state management patterns]

## Git Rules
- Commit format: [infer from git log or use: TYPE(scope): description]
- Branch strategy: feature/ for new features, fix/ for bugs
- Never push directly to main

## Key Files
[list 5-10 most important files Claude should know about]

## Environment Variables
[list from .env.example if it exists, else list what you can infer]

## Security Rules  
- Never read .env or .env.*
- Never expose API keys in logs
- [add stack-specific rules]
```

---

### agents/ (AI teammates)

Generate these agents based on the stack. Write each as `.claude/agents/NAME.md`:

**Always generate:**

1. `code-reviewer.md` — reviews PRs for bugs, security, performance
2. `debugger.md` — diagnoses runtime errors and traces root causes  
3. `test-writer.md` — writes tests in the project's test framework

**Generate if applicable:**

4. `db-migrator.md` — if project has a database (Prisma/Drizzle/SQLAlchemy etc.)
5. `api-designer.md` — if project has an API layer
6. `ui-builder.md` — if project has a frontend framework
7. `security-auditor.md` — always useful for any web app

Each agent file format:
```
---
name: [agent-name]
description: [one line — what it does, when Claude should invoke it]
tools: [Read, Write, Bash, Glob, Grep — only what it needs]
model: sonnet
---

You are [project name]'s [role].

## Context
[2-3 lines about the project stack relevant to this agent]

## Step 1: [First action]
[specific commands to run, files to read]

## Step 2: [Second action]  
...

## Output format
[how to structure the response]
```

---

### commands/ (one-word automations)

Generate these slash commands. Write each as `.claude/commands/NAME.md`:

**Always generate:**

1. `test.md` — run full test suite with coverage
2. `lint.md` — run linter + formatter check
3. `pr-review.md` — review staged changes before opening PR

**Generate based on stack:**

4. `deploy.md` — if deployment target detected (Vercel/Railway/Fly/Docker)
5. `db-migrate.md` — if ORM detected
6. `seed-db.md` — if project has seed scripts
7. `typecheck.md` — if TypeScript detected
8. `e2e.md` — if Playwright/Cypress detected

Each command format:
```
---
name: [command-name]
description: [what it does]
disable-model-invocation: true
---

[Context: what project this is for]

## Pre-flight
[numbered list of checks to run first]

## Execute
[numbered list of actual commands]

## Verify
[how to confirm it worked]

## If anything fails
[specific recovery steps — never skip, never force]
```

---

### hooks/ (auto-run scripts)

Write `.claude/hooks/pre-commit.sh`:

Generate a bash script that:
1. Runs the project's type checker (tsc --noEmit / mypy / etc.) if applicable
2. Runs linter on staged files only (not all files)
3. Runs the test suite
4. Blocks commit if anything fails with a clear error message
5. Uses the actual binary names from the detected stack

Write `.claude/hooks/lint-on-save.sh`:

Generate a bash script that:
1. Runs the formatter on the saved file
2. Uses the actual formatter from the stack (Prettier / Biome / Ruff / gofmt / etc.)
3. Is silent on success, loud on failure

Make both scripts executable-ready (start with `#!/bin/bash`).

---

### rules/ (guardrails)

Generate rule files scoped to actual folder patterns in the project:

1. If API routes exist → `api.md` scoped to the API folder
2. If database folder/migrations exist → `database.md` scoped to it
3. If frontend components exist → `frontend.md` scoped to components folder

Each rule file format:
```
---
paths:
  - "actual/path/**"
  - "src/actual/path/**"
---

# [Domain] Rules

## [Rule category]
- [specific guardrail]
- [specific guardrail]
```

---

### settings.json

Write `.claude/settings.json`:

```json
{
  "permissions": {
    "allow": [
      "[add the actual lint/test/build commands for this stack]",
      "Bash(git diff *)",
      "Bash(git log *)",
      "Bash(git status)",
      "Bash(git add *)",
      "Bash(git commit *)",
      "Bash(gh issue *)",
      "Bash(gh pr *)"
    ],
    "deny": [
      "Read(.env)",
      "Read(.env.*)",
      "Read(secrets/**)",
      "Bash(rm -rf *)",
      "Bash(git push --force *)",
      "Bash(curl *)",
      "Bash(wget *)"
    ]
  },
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [{
          "type": "command",
          "command": ".claude/hooks/pre-commit.sh"
        }]
      }
    ],
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [{
          "type": "command",
          "command": ".claude/hooks/lint-on-save.sh"
        }]
      }
    ]
  },
  "model": "claude-sonnet-4-6",
  "autoMemoryEnabled": true
}
```

---

## Step 4: Report

After writing all files, output:

```
✓ Generated .claude/ setup for [Project Name]

Stack detected:
  Framework: [X]
  Language:  [X]
  Database:  [X]
  Testing:   [X]
  Deploy:    [X]

Files created:
  CLAUDE.md
  agents/   [list]
  commands/ [list]  
  hooks/    [list]
  rules/    [list]
  settings.json

Next steps:
  1. chmod +x .claude/hooks/*.sh
  2. Review CLAUDE.md and fill in any [UNKNOWN] fields
  3. Add your real environment variable names to CLAUDE.md
  4. Run: claude "/test" to verify test command works
```
