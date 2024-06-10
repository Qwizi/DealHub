#!/bin/bash
# This script load stock data
set -e
set -o pipefail
echo "Loading stock data"
USERS_COUNT=$(docker compose exec -T app python manage.py shell -c 'from django.contrib.auth import get_user_model; User = get_user_model(); print(User.objects.count());')
echo "Users count: $USERS_COUNT"

if [ "$USERS_COUNT" = "1" ]; then
  docker compose exec -T app python manage.py loaddata accounts
fi

CATEGORIES_COUNT=$(docker compose exec -T app python manage.py shell -c 'from categories.models import Category; print(Category.objects.count());')
echo "Categories count: $CATEGORIES_COUNT"

if [ "$CATEGORIES_COUNT" = "0" ]; then
  docker compose exec -T app python manage.py loaddata categories
fi

OFFERS_COUNT=$(docker compose exec -T app python manage.py shell -c 'from offers.models import Offer; print(Offer.objects.count());')

echo "Offers count: $OFFERS_COUNT"

if [ "$OFFERS_COUNT" = "0" ]; then
  docker compose exec -T app python manage.py loaddata offers
fi

echo "Stock data loaded"