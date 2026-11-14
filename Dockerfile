# n8n 2.47.7 wrapper for Railway (n8n with Postgres template).
#
# Everything the deploy form should not ask for is baked here as ENV: Railway's
# template generator drops literal variable defaults, so a literal left on the
# service publishes as a blank required field. Only references to the Postgres
# service and generated secrets stay as template variables.
# upstream: n8n-io/n8n
FROM n8nio/n8n:2.47.7

ENV DB_TYPE=postgresdb \
    DB_POSTGRESDB_PORT=5432 \
    N8N_PROTOCOL=https \
    GENERIC_TIMEZONE=UTC \
    N8N_LISTEN_ADDRESS=:: \
    N8N_RUNNERS_ENABLED=true \
    N8N_DIAGNOSTICS_ENABLED=false \
    N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true

# Railway injects PORT into every service and its healthcheck dials that port,
# not the one the app was configured for. n8n listens on N8N_PORT, so derive it
# from PORT at boot instead of baking a literal 5678.
COPY railway-entrypoint.sh /usr/local/bin/railway-entrypoint.sh
USER root
RUN chmod +x /usr/local/bin/railway-entrypoint.sh
USER node

ENTRYPOINT ["tini", "--", "/usr/local/bin/railway-entrypoint.sh"]
