---
paths:
  - "**"
---

# General Rules

## Code quality
- Functions under 50 lines. If longer, split it.
- No commented-out code in commits. Delete it or keep it.
- No `console.log` in committed code unless it's a CLI tool.
- No `any` in TypeScript. No `# type: ignore` in Python without a comment explaining why.

## File operations
- Never delete files without confirming with the user first.
- Never overwrite a file that has significant content without showing a diff first.
- Never write to `.env`, `.env.*`, `secrets/`, or any credentials file.

## Git
- Never run `git push --force` under any circumstance.
- Never commit directly to `main` or `master`.
- Commit message must describe *what changed and why*, not just "fix" or "update".

## When stuck
- Don't loop more than 3 times on the same problem. Stop and explain what's blocking you.
- Don't hallucinate library APIs. Run the code to verify it works.
- If tests fail after your change, fix the tests or revert — don't disable them.
