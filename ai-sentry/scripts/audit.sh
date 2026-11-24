#!/usr/bin/env bash
# One-shot AISentry audit: start the local agent on a spare port, read one scan, stop it.
# Prints the scan as JSON (processes, permissions with risk ratings, network endpoints, session stats).
# Reads only file sizes/mtimes, agent settings files, the last 8 KB of ~/.claude/history.jsonl, ps and lsof.
set -euo pipefail
DIR="$(cd "$(dirname "$0")/.." && pwd)"
PORT="${PORT:-4299}"
command -v node >/dev/null || { echo "node is required" >&2; exit 1; }

PORT="$PORT" AISENTRY_HOST="${AISENTRY_HOST:-https://aisentry.netlify.app}" \
  node "$DIR/app/public/agent.js" >/dev/null 2>&1 &
PID=$!
trap 'kill $PID 2>/dev/null || true' EXIT

for _ in $(seq 1 50); do curl -sf "http://127.0.0.1:$PORT/ping" >/dev/null && break; sleep 0.2; done
# The first SSE message is a full scan; strip the "data: " prefix and stop after it.
curl -sN --max-time 20 "http://127.0.0.1:$PORT/events" | grep -m1 '^data: ' | sed 's/^data: //'
