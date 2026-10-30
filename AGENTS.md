# Common Agent Rules

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
