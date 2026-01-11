#!/bin/bash
set -e

SITE_NAME=${SITE_NAME:-crm.local}

echo "Waiting for database..."
sleep 15

cd /home/frappe/frappe-bench

if [ ! -d "sites/$SITE_NAME" ]; then
  echo "Creating site $SITE_NAME"

    bench new-site "$SITE_NAME" \
    --admin-password "$ADMIN_PASSWORD" \
    --db-host "$DB_HOST" \
    --db-name "$DB_NAME" \
    --db-password "$DB_PASSWORD" \
    --db-root-username "$DB_USER" \
    --db-root-password "$DB_PASSWORD" \
    --mariadb-user-host-login-scope='%'


  bench --site $SITE_NAME install-app crm
fi

exec bench start
