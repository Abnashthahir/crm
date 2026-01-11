FROM frappe/bench:latest

# Set environment variables
ENV FRAPPE_ENV=production
ENV SITE_NAME=crm.local
ENV DB_HOST=${DB_HOST}
ENV DB_PORT=3306
ENV DB_NAME=${DB_NAME}
ENV DB_PASSWORD=${DB_PASSWORD}
ENV REDIS_CACHE=${REDIS_CACHE}
ENV REDIS_QUEUE=${REDIS_QUEUE}
ENV REDIS_SOCKETIO=${REDIS_SOCKETIO}

WORKDIR /home/frappe/frappe-bench

# Get CRM app
RUN bench get-app crm https://github.com/frappe/crm.git

# Create site (no DB init yet)
RUN bench new-site $SITE_NAME \
    --admin-password admin \
    --mariadb-root-password admin \
    --no-mariadb-socket

# Install CRM
RUN bench --site $SITE_NAME install-app crm

# Expose ports
EXPOSE 8000 9000

CMD ["bench", "start"]
