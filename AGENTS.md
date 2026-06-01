# Common Agent Rules

## Feature Development Workflow

Every new feature must go through a design phase before any code is written. Docs live under `repo_root/docs/<feature-name>/` and contain five files.

```
docs/
  <feature-name>/          # active — in progress
    proposal.md   # Background, goals, non-goals, design principles
    design.md     # Data model, API design, frontend state, directory changes
    tasks.md      # Phased task checklist + acceptance criteria
    context.md    # Running log of decisions, blockers, and open questions
    tests.md      # Manual + automated test scenarios, edge cases, acceptance checks
  archive/
    <feature-name>/        # completed and verified features
```

When all acceptance criteria are met and verified, move the feature folder to `repo_root/docs/archive/`.

### proposal.md must include

- **Background**: What problem exists today
- **Goals**: What this feature will deliver
- **Non-Goals**: Explicitly what is out of scope (prevents scope creep)
- **Design Principles**: Key decision rationale (e.g. "simplicity first", "data-driven UI")
- **Constraints**: Deploy environment, performance requirements, compatibility

### design.md must include

- **Data model**: Table schema (fields, types, descriptions); relational vs document distinction
- **Core flow**: Key scenarios described in prose + ASCII diagrams
- **API design**: Method, path, request body, response for every endpoint
- **Frontend state**: State shape, data flow, hook responsibilities
- **Storage rationale**: Why this storage engine was chosen
- **Directory changes**: List of new/modified files

### tasks.md must include

- Tasks split by Phase (Phase 1 = infrastructure, Phase 2 = API layer, Phase 3 = frontend integration, Phase 4+ = deferrable)
- Each task as a `- [ ]` checkbox for progress tracking
- **Acceptance criteria** at the end, expressed as observable user-facing behaviors

### context.md must include

- Running log of decisions made during implementation (date-stamped entries)
- Open questions and blockers, updated as they are resolved
- Links to relevant commits or PRs

### tests.md must include

- Manual test scenarios covering the golden path and key edge cases
- Automated test scenarios (unit + integration) with file paths
- Regression checks for features adjacent to the new work
- Maintain test cases under `repo_root/test/`.

---

## Todo List

A single `repo_root/todo.md` tracks all pending work across every project in this repo. Keep it up to date:

- Add items when new tasks or bugs are identified.
- When a todo item is ready to start, move it out of `todo.md` and create the corresponding `docs/<feature-name>/` folder instead.

---

## Decision Ownership

Surface key decisions to the user before acting on them. Do not resolve significant design or scope choices unilaterally.

---

## Relationship to Karpathy Guidelines

These rules complement the [Karpathy guidelines](https://raw.githubusercontent.com/multica-ai/andrej-karpathy-skills/main/CLAUDE.md) and must not duplicate or contradict them.

The Karpathy guidelines own: **Think Before Coding**, **Simplicity First**, **Surgical Changes**, and **Goal-Driven Execution**. Do not restate or override those principles here.

Rules added to this file must cover workflow, process, or project-specific conventions that the Karpathy guidelines do not address (e.g. doc structure, build tooling, todo tracking).

---

## Build & Run Convention

**Always use `docker compose` — never `npm run build` or `npm run dev`.**

```bash
docker compose up --build   # build and start
docker compose up -d        # start in background
docker compose down         # stop
```
