---
name: ai-sentry
description: "Audit the AI coding agents on this machine (Claude Code, Codex CLI, Gemini CLI, Aider, Cursor, Copilot): running processes, risky permissions, unknown network endpoints, background daemons and session usage. Use when the user asks whether a skill, plugin or MCP server is doing something fishy, why their quota is burning, what agents or daemons are running, which permissions are too broad, or wants a live monitoring dashboard."
---

# AI Sentry

Local, read-only monitor for AI coding agents. The code lives in `app/` (zero-dependency Node). Full docs: `app/README.md`.

## One-shot audit (default)
Run `bash scripts/audit.sh` from this skill's folder. It starts the agent on `127.0.0.1:4299`, prints one JSON scan and stops it. It needs Node and curl, and on Linux also `ps` and `lsof`.

The JSON fields:
- `processes`: detected agent processes (claude, codex, gemini, aider, copilot, claude-flow/ruflo …).
- `permissions`: allow rules from `.claude/settings.json`, Codex `config.json`, Gemini and Cursor settings. Each has a `risk` of `critical`, `high`, `medium`, `low` or `ok`.
- `network`: open sockets of agent processes. Anthropic, OpenAI, Google and GitHub endpoints are `ok`; anything else is flagged.
- `stats`, `hourBuckets`, `projects`, `recentActivity`: session counts and sizes. It never reads conversation content.

Report to the user, most severe first:
1. `critical` and `high` permissions, with the file path and rule. Examples: `Bash(node .claude/*)`, `fullAuto: true`, `approvalPolicy: never`, broad wildcards, model overrides.
2. Unknown endpoints, with the process that opened them.
3. Unexpected background processes or daemons.

Recommend a fix for each finding. Don't edit settings files unless the user asks.

## Live dashboard (optional)
- Hosted: `curl -fsSL https://aisentry.netlify.app/install.sh | bash`, then open `https://aisentry.netlify.app/monitor`. This installs to `~/.aisentry` and registers a login item, so ask the user first.
- From source, with no install: `cd app && npm run dev` (serves on :8080). In a second terminal, run `npm run dev:agent`, then open `http://localhost:8080/monitor.html`.

## Privacy
The agent binds to 127.0.0.1 only. It makes one outbound request, `GET <host>/version.json`, to check for updates. It never reads API keys, `.env` files, the keychain or session contents.
