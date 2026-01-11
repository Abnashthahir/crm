FROM frappe/bench:latest

WORKDIR /home/frappe

# Initialize bench
RUN bench init frappe-bench --skip-assets --python python3

WORKDIR /home/frappe/frappe-bench

# Get CRM app
RUN bench get-app crm https://github.com/frappe/crm.git

# Copy entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 8000

ENTRYPOINT ["/entrypoint.sh"]
