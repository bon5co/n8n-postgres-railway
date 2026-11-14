#!/bin/sh
# Honour the port Railway injects (default 5678 outside Railway), then hand over
# to upstream's entrypoint unchanged.
set -eu
export N8N_PORT="${PORT:-5678}"
echo "[railway-entrypoint] n8n listening on ${N8N_PORT}"
exec /docker-entrypoint.sh "$@"
