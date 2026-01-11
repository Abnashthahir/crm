FROM frappe/bench:latest

WORKDIR /home/frappe/frappe-bench

# Get CRM app only (safe at build time)
RUN bench get-app crm https://github.com/frappe/crm.git

EXPOSE 8000

# Start script
CMD ["bash", "-c", "bench start"]
