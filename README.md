# ai-skills

Open agent skills by [thatsuperdev](https://github.com/thatsuperdev). Each top-level folder is one skill with its own `SKILL.md`, the open [Agent Skills](https://agentskills.io) format. They work with Claude Code, Codex and any other agent that reads `SKILL.md`.

| Skill | What it does |
|---|---|
| [`ai-sentry`](ai-sentry) | Audits the AI coding agents on your machine (Claude Code, Codex, Gemini CLI, Aider, Cursor, Copilot): running processes, risky permissions, unknown network endpoints and background daemons. Includes the full AISentry app (a zero-dependency Node agent and a live dashboard). |
| [`assembly-video`](assembly-video) | Makes a hyper-realistic Blender video in which a product builds itself piece by piece, then comes alive with light, with music, at 4:5 for X/Instagram. Includes the full prompt template. |

## Install

**Claude Code (plugin):**
```
/plugin marketplace add thatsuperdev/ai-skills
/plugin install ai-skills@thatsuperdev-ai-skills
```

**Any agent (Claude Code, Codex, others), by hand:**
```bash
git clone https://github.com/thatsuperdev/ai-skills ~/ai-skills
mkdir -p ~/.agents/skills ~/.claude/skills ~/.codex/skills
for s in ~/ai-skills/*/; do
  n=$(basename "$s")
  ln -sfn "$s" ~/.agents/skills/$n   # Codex and other Agent Skills readers
  ln -sfn "$s" ~/.claude/skills/$n   # Claude Code
  ln -sfn "$s" ~/.codex/skills/$n    # older Codex versions
done
```
Run `git pull` in `~/ai-skills` to update every agent at once.

**Agents without skill support:** paste the skill's `SKILL.md` into the agent's instructions (for example `AGENTS.md`) and point it at the folder.

## Use
- *"Is any plugin on my machine doing something fishy?"* runs `ai-sentry`'s one-shot audit (`ai-sentry/scripts/audit.sh`).
- *"Make an assembly video of a mechanical keyboard in glass"* starts `assembly-video`. It needs Blender, and the agent asks before installing it.

## Notes
- `ai-sentry` is read-only. It binds to 127.0.0.1 and never reads conversation content, API keys or `.env` files. It moved here from `thatsuperdev/ai-sentry` with its full git history. The app lives in `ai-sentry/app/`; to deploy the dashboard on Netlify, set the base directory to `ai-sentry/app`.
- The `assembly-video` prompt is adapted from a public "copy and use" prompt carousel. Downloads are restricted to Pixabay, incompetech.com and Poly Haven, and credits are logged per video.

## License
MIT
