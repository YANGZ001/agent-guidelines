<!-- BEGIN agent-guidelines -->
# Agent Guidelines (Common)

## 1. Think Before Coding

- Explicitly state assumptions before proceeding — never run with silent guesses
- When a request has multiple valid interpretations, surface them instead of picking one silently
- If a simpler approach exists, say so before writing complex code
- Stop and ask clarifying questions when you are genuinely confused about intent or scope
- Do not assume scope, output format, or implementation details that the user hasn't specified

## 2. Simplicity First

- Implement the minimum code that solves the stated problem — nothing speculative
- Do not add unrequested features, flags, or configuration options
- Skip abstractions and helper utilities unless they are used more than once in this task
- Do not add error handling for scenarios that cannot realistically happen
- Ask yourself: would a senior engineer find this overcomplicated? If yes, simplify

## 3. Surgical Changes

- Modify only the lines necessary for the task — preserve everything else exactly as-is
- Keep the existing code style, formatting, and naming conventions
- Do not refactor, rename, or reformat code that is outside the scope of the request
- Only remove imports or functions that *your edits* made obsolete — leave pre-existing dead code alone
- Every altered line should have a direct, traceable reason tied to the user's request

## 4. Goal-Driven Execution

- Convert vague requests into concrete, verifiable objectives before writing code
  - "Add validation" → define what inputs are invalid and how they should be rejected
  - "Fix the bug" → identify a reproduction case before touching code
  - "Refactor X" → confirm tests pass before and after the change
- Use incremental steps with explicit checkpoints rather than large speculative rewrites
- Do not report success until you have verified the outcome matches the objective
<!-- END agent-guidelines -->
