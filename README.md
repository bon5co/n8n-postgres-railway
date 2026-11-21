# n8n for Railway

Wraps the official `n8nio/n8n` image (2.48.7) for the Railway "n8n with Postgres"
template, published as `ghcr.io/bon5co/n8n-postgres-railway:2.48.7`.

Railway's template generator keeps a variable default only when it is a Railway
expression (`${{secret(n)}}`, `${{svc.VAR}}`); literals publish as blank required
fields. This image bakes the literals instead:

| Variable | Value |
| --- | --- |
| `DB_TYPE` | `postgresdb` |
| `DB_POSTGRESDB_PORT` | `5432` |
| `N8N_PROTOCOL` | `https` |
| `GENERIC_TIMEZONE` | `UTC` |
| `N8N_LISTEN_ADDRESS` | `::` |
| `N8N_RUNNERS_ENABLED` | `true` |
| `N8N_DIAGNOSTICS_ENABLED` | `false` |
| `N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS` | `true` |

`N8N_PORT` is set at boot from Railway's injected `PORT` (see
`railway-entrypoint.sh`), so the healthcheck and the edge proxy dial the port n8n
actually listens on.
