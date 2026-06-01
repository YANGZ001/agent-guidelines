# agent-guidelines

Common AI agent guidelines for every project. Deploy with one command.

## Usage

```bash
# From inside any project:
cd /path/to/my-project
/path/to/agent-guidelines/scripts/update_guidelines.sh

# Or with an explicit path:
./agent-guidelines/scripts/update_guidelines.sh /path/to/my-project
```

The script fetches the latest [Karpathy guidelines](https://github.com/multica-ai/andrej-karpathy-skills) from GitHub, combines them with your common rules, and writes the result into the project's `AGENTS.md`. If `TARGET_DIR/.claude/` is a git repository, it also pulls the latest official skills. Idempotent — safe to re-run.

## Setup for a new machine

```bash
git clone https://github.com/YANGZ001/agent-guidelines.git
```

## Adding your own common rules

Edit `AGENTS.md` in this repo. These rules are prepended to every project's guidelines above the Karpathy content.

## How it works

| File | Purpose |
|------|---------|
| `AGENTS.md` | Your common rules (maintained here) |
| `CLAUDE.md` | `@AGENTS.md` — Claude Code follows the reference at runtime |
| `scripts/update_guidelines.sh` | Deploys combined guidelines into a target project |

After running the script, the target project's `AGENTS.md` contains:

```
[existing project-specific rules, if any]

<!-- BEGIN agent-guidelines -->
[your common rules from this repo]

[latest Karpathy guidelines, fetched from GitHub]
<!-- END agent-guidelines -->
```
