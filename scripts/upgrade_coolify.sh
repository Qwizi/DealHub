#!/bin/bash
## Do not modify this file. You will lose the ability to autoupdate!

# shellcheck disable=SC2034
VERSION="0.0.2"
CDN="https://raw.githubusercontent.com/Qwizi/DealHub/master"
PROJECT_NAME="DealHub"

# Get app container name
APP_CONTAINER_NAME=$(docker ps --filter ancestor=qwizii/dealhub:latest --format "{{.Names}}")

if [ -z "$APP_CONTAINER_NAME" ]; then
    echo "App container not found. Exiting..."
    exit 1
fi

# make migrations
docker exec -it "$APP_CONTAINER_NAME" python manage.py migrate

# Get the count of superusers
SUPERUSER_COUNT=$(docker exec -it "$APP_CONTAINER_NAME" app python manage.py shell -c "from django.contrib.auth import get_user_model; User = get_user_model(); print(User.objects.filter(is_superuser=True).count());")

# Create superuser if none exists
if [ "$SUPERUSER_COUNT" = "0" ]; then
    SUPERUSER_PASSWORD=$(openssl rand -hex 16)
    docker exec -it "$APP_CONTAINER_NAME" app python manage.py shell -c "from django.contrib.auth import get_user_model; User = get_user_model(); User.objects.create_superuser(username='admin', password='$SUPERUSER_PASSWORD', email=None);"
    echo "Superuser admin created with password $SUPERUSER_PASSWORD"
fi

echo "Loading stock data"
USERS_COUNT=$(docker exec -it "$APP_CONTAINER_NAME" app python manage.py shell -c 'from django.contrib.auth import get_user_model; User = get_user_model(); print(User.objects.count());')
echo "Users count: $USERS_COUNT"

if [ "$USERS_COUNT" = "1" ]; then
  docker exec -it "$APP_CONTAINER_NAME" app python manage.py loaddata accounts
fi

CATEGORIES_COUNT=$(docker exec -it "$APP_CONTAINER_NAME" app python manage.py shell -c 'from categories.models import Category; print(Category.objects.count());')
echo "Categories count: $CATEGORIES_COUNT"

if [ "$CATEGORIES_COUNT" = "0" ]; then
  docker exec -it "$APP_CONTAINER_NAME" app python manage.py loaddata categories
fi

OFFERS_COUNT=$(docker exec -it "$APP_CONTAINER_NAME" app python manage.py shell -c 'from offers.models import Offer; print(Offer.objects.count());')

echo "Offers count: $OFFERS_COUNT"

if [ "$OFFERS_COUNT" = "0" ]; then
  docker exec -it "$APP_CONTAINER_NAME" app python manage.py loaddata offers
fi

echo "Stock data loaded"