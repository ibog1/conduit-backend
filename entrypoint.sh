#!/bin/bash
set -e

echo "Waiting for PostgreSQL..."
while ! nc -z db 5432; do
  echo "DB not ready - sleeping..."
  sleep 1
done
echo "PostgreSQL ready!"

echo "Running Django migrations..."
python manage.py migrate

echo "Collecting static files..."  # ← NEU!
python manage.py collectstatic --noinput

echo "Starting Gunicorn..."
exec gunicorn -w 4 -b 0.0.0.0:5000 conduit.wsgi:application
