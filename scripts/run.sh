#!/bin/bash
# This script is only to help on dev environment
set -e
set -o pipefail

# Run containers
docker compose up -d --build

# Run migrations
docker compose exec app python manage.py migrate

# Check if superuser not exists
SUPERUSER_COUNT=$(docker compose exec -T app python manage.py shell -c 'from django.contrib.auth import get_user_model; User = get_user_model(); print(User.objects.filter(is_superuser=True).count());')

echo "Superusers count: $SUPERUSER_COUNT"

if [ "$SUPERUSER_COUNT" = "0" ]; then
  echo "Creating superuser"
    # Create superuser
  docker compose exec -T app python manage.py shell -c 'from django.contrib.auth import get_user_model; User = get_user_model(); User.objects.create_superuser(username="admin", password="admin", email=None)'
  echo "Superuser admin with password admin created"
fi

echo "App is running on http://localhost:8000/"