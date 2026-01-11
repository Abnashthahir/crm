#!/bin/bash
set -e

SITE_NAME=${SITE_NAME:-crm.local}

echo "Waiting for database..."
sleep 15

cd /home/frappe/frappe-bench

echo "Writing Redis configuration..."
cat > sites/common_site_config.json <<EOF
{
  "redis_cache": "$REDIS_CACHE",
  "redis_queue": "$REDIS_QUEUE",
  "redis_socketio": "$REDIS_SOCKETIO"
}
EOF

if [ ! -d "sites/$SITE_NAME" ]; then
  echo "Creating site $SITE_NAME"

  bench new-site "$SITE_NAME" \
    --admin-password "$ADMIN_PASSWORD" \
    --db-host "$DB_HOST" \
    --db-name "$DB_NAME" \
    --db-password "$DB_PASSWORD" \
    --db-root-username "$DB_USER" \
    --db-root-password "$DB_PASSWORD" \
    --mariadb-user-host-login-scope='%' \
    --force

  echo "Installing CRM app"
  bench --site "$SITE_NAME" install-app crm
else
  echo "Site $SITE_NAME already exists, skipping creation"
fi

echo "Starting Frappe..."
exec bench start
