#!/bin/bash
set -e

# Wait for Postgres to be ready
until pg_isready -h postgres -U airflow; do
  echo "Waiting for Postgres..."
  sleep 2
done

airflow db upgrade

# Create admin user if not exists
airflow users list | grep -q ' admin ' || \
  airflow users create \
    --username admin \
    --firstname Admin \
    --lastname User \
    --role Admin \
    --email admin@example.com \
    --password admin

exec "$@"
