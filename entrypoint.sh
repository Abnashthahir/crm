#!/bin/bash
set -e

SITE_NAME=${SITE_NAME:-crm.local}
SITES_PATH="/home/frappe/frappe-bench/sites"

echo "Starting Frappe container..."
cd /home/frappe/frappe-bench

echo "Writing Redis configuration..."
cat > sites/common_site_config.json <<EOF
{
  "redis_cache": "$REDIS_CACHE",
  "redis_queue": "$REDIS_QUEUE",
  "redis_socketio": "$REDIS_SOCKETIO"
}
EOF

if [ ! -d "$SITES_PATH/$SITE_NAME" ]; then
  echo "First-time setup: creating site $SITE_NAME"

  bench new-site "$SITE_NAME" \
    --admin-password "$ADMIN_PASSWORD" \
    --db-host "$DB_HOST" \
    --db-name "$DB_NAME" \
    --db-user "$DB_USER" \
    --db-password "$DB_PASSWORD" \
    --no-setup-db

  echo "Running migrations"
  bench --site "$SITE_NAME" migrate

  echo "Installing CRM app"
  bench --site "$SITE_NAME" install-app crm
else
  echo "Site already exists in volume. Skipping creation."
fi

echo "Starting Frappe..."
exec bench start
