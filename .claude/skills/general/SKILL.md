---
name: general
description: General coding standards and patterns. Applied across all projects as a baseline.
user-invocable: false
---

## When writing any code

1. Read the file you're about to edit before touching it.
2. Match the existing code style exactly — indentation, naming, import order.
3. Write the smallest change that solves the problem.
4. After every write, re-read the file to check for syntax errors.

## When running bash commands

1. Always check exit codes.
2. Never pipe untrusted input to bash.
3. Prefer read-only commands first to understand before modifying.

## When stuck in a loop

Stop after 3 attempts at the same approach. 
Say: "I've tried [X] three times and it's not working because [Y]. Here are two different approaches: ..."

## Error messages

Always include:
- What you were trying to do
- The exact error
- What you tried
- What you think the cause is
