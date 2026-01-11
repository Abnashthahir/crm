FROM frappe/bench:latest

WORKDIR /home/frappe

# Init bench (no redis, no assets)
RUN bench init frappe-bench \
    --skip-assets \
    --skip-redis-config-generation \
    --python python3

WORKDIR /home/frappe/frappe-bench

# Get CRM app
RUN bench get-app crm https://github.com/frappe/crm.git

# Copy entrypoint with correct ownership
COPY --chown=frappe:frappe entrypoint.sh /home/frappe/entrypoint.sh

EXPOSE 8000

ENTRYPOINT ["/home/frappe/entrypoint.sh"]
