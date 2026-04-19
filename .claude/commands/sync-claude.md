---
name: sync-claude
description: Re-generates outdated .claude files when you add a new library, change deployment target, or update the stack
disable-model-invocation: false
---

You are updating an existing `.claude/` setup to reflect changes in the project stack.

## Step 1: Understand what changed

Ask the user: "What changed in the stack?" if not specified.
Common triggers:
- Added a new major dependency (new DB, auth provider, test framework)
- Changed deployment target
- Restructured folders
- Added/removed TypeScript

## Step 2: Read current state

- `cat .claude/CLAUDE.md` — see what's already documented
- `cat package.json` — see current deps
- `ls .claude/agents/ .claude/commands/ .claude/hooks/` — see what exists

## Step 3: Diff and update

Only regenerate files that are stale. For each changed area:
- Update `CLAUDE.md` tech stack + commands sections
- Add/remove agents for new/removed tools
- Add/remove commands for new/removed scripts
- Update `settings.json` allow list for new dev commands
- Update hooks if linter/formatter changed

## Step 4: Report

List exactly which files were updated and why. Never delete existing files without confirming.
