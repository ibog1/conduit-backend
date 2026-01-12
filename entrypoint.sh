#!/bin/bash
set -e

# 1. Warte auf PostgreSQL
echo "Waiting for PostgreSQL..."
while ! nc -z db 5432; do
  echo "DB not ready - sleeping..."
  sleep 1
done
echo "PostgreSQL ready!"

# 2. Django Migrations
echo "Running Django migrations..."
python manage.py migrate

# 3. Starte Gunicorn
echo "Starting Gunicorn..."
exec gunicorn -w 4 -b 0.0.0.0:5000 conduit.wsgi:application
