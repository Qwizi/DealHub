# This script load stock data
Write-Host "Loading stock data"

$USERS_COUNT = docker compose exec -T app python manage.py shell -c 'from django.contrib.auth import get_user_model; User = get_user_model(); print(User.objects.count());'
Write-Host "Users count: $USERS_COUNT"

if ($USERS_COUNT -eq "1") {
  docker compose exec -T app python manage.py loaddata accounts
}

$CATEGORIES_COUNT = docker compose exec -T app python manage.py shell -c 'from categories.models import Category; print(Category.objects.count());'
Write-Host "Categories count: $CATEGORIES_COUNT"

if ($CATEGORIES_COUNT -eq "0") {
  docker compose exec -T app python manage.py loaddata categories
}

$OFFERS_COUNT = docker compose exec -T app python manage.py shell -c 'from offers.models import Offer; print(Offer.objects.count());'
Write-Host "Offers count: $OFFERS_COUNT"

if ($OFFERS_COUNT -eq "0") {
  docker compose exec -T app python manage.py loaddata offers
}

Write-Host "Stock data loaded"