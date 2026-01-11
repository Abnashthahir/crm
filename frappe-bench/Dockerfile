# Dockerfile for Frappe CRM Backend on Railway
FROM frappe/frappe-worker:v15

# Set environment variables
ENV FRAPPE_USER=frappe \
    FRAPPE_HOME=/home/frappe \
    FRAPPE_SITE_NAME=crm.localhost \
    MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD} \
    DB_HOST=${DB_HOST} \
    DB_PORT=${DB_PORT} \
    REDIS_HOST=${REDIS_HOST} \
    REDIS_PORT=${REDIS_PORT}

# Install CRM app
RUN bench get-app crm https://github.com/frappe/crm --branch develop

# Create a new site and install CRM app
RUN bench new-site $FRAPPE_SITE_NAME \
    --mariadb-root-password $MYSQL_ROOT_PASSWORD \
    --admin-password admin \
    --install-app crm

# Expose port 8000 (default Frappe port)
EXPOSE 8000

# Start the Frappe server
CMD ["bench", "start"]