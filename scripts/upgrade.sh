#!/bin/bash
## Do not modify this file. You will lose the ability to autoupdate!

# shellcheck disable=SC2034
VERSION="0.0.2"
CDN="https://raw.githubusercontent.com/Qwizi/DealHub/master"
PROJECT_NAME="DealHub"

curl -fsSL $CDN/docker-compose.prod.yml -o $PROJECT_NAME/docker-compose.yml
curl -fsSL $CDN/.env.example -o $PROJECT_NAME/.env.example
curl -fsSL $CDN/nginx/default.conf -o $PROJECT_NAME/default.conf
curl -fsSL $CDN/scripts/upgrade.sh -o $PROJECT_NAME/upgrade.sh

# Docker Compose command
DOCKER_COMPOSE_CMD="docker compose --env-file $PROJECT_NAME/.env -f $PROJECT_NAME/docker-compose.yml"

# Rebuild containers and run migrations
$DOCKER_COMPOSE_CMD up -d --pull always --remove-orphans --force-recreate
$DOCKER_COMPOSE_CMD exec -T app python manage.py migrate

# Get the count of superusers
SUPERUSER_COUNT=$($DOCKER_COMPOSE_CMD exec -T app python manage.py shell -c "from django.contrib.auth import get_user_model; User = get_user_model(); print(User.objects.filter(is_superuser=True).count());")

# Create superuser if none exists
if [ "$SUPERUSER_COUNT" = "0" ]; then
    SUPERUSER_PASSWORD=$(openssl rand -hex 16)
    $DOCKER_COMPOSE_CMD exec -T app python manage.py shell -c "from django.contrib.auth import get_user_model; User = get_user_model(); User.objects.create_superuser(username='admin', password='$SUPERUSER_PASSWORD', email=None);"
    echo "Superuser admin created with password $SUPERUSER_PASSWORD"
    echo "Go to http://localhost:8000/admin/password_change/ and login with the superuser to change the password"
fi

echo "$PROJECT_NAME has been updated!"
echo "$PROJECT_NAME is running at http://localhost:8000/"