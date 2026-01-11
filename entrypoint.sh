#!/bin/bash
set -e

SITE_NAME=${SITE_NAME:-crm.local}

echo "Waiting for DB..."
sleep 10

if [ ! -d "sites/$SITE_NAME" ]; then
  echo "Creating new site: $SITE_NAME"

  bench new-site $SITE_NAME \
    --admin-password $ADMIN_PASSWORD \
    --db-host $DB_HOST \
    --db-name $DB_NAME \
    --db-password $DB_PASSWORD \
    --no-mariadb-socket

  bench --site $SITE_NAME install-app crm
fi

exec bench start
