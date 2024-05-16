#!/bin/bash
## Do not modify this file. You will lose the ability to autoupdate!

VERSION="0.0.1"
CDN="https://raw.githubusercontent.com/Qwizi/DealHub/master"

echo -e "-------------"
echo -e "Welcome to DealHub updater!"
echo -e "This script will update your DealHub instance."
echo -e "-------------"

echo "Downloading required files from CDN..."
curl -fsSL $CDN/docker-compose.prod.yml -o DealHub/docker-compose.yml
curl -fsSL $CDN/env.example -o DealHub/.env.example
curl -fsSL $CDN/nginx/default.conf -o DealHub/default.conf
curl -fsSL $CDN/scripts/upgrade.sh -o DealHub/upgrade.sh

chmod +x DealHub/upgrade.sh

# Check if SECRET_KEY is insecure
if grep -q "SECRET_KEY=django-insecure" DealHub/.env; then
    DJANGO_SECRET_KEY=$(openssl rand -hex 50)
    sed -i "s|SECRET_KEY=.*|SECRET_KEY=$DJANGO_SECRET_KEY|g" DealHub/.env
  fi

# Rebuild containers
docker compose --env-file DealHub/.env -f DealHub/docker-compose.yml up -d --pull always --remove-orphans --force-recreate

# Run migrations
docker compose --env-file DealHub/.env -f DealHub/docker-compose.yml exec -T app python manage.py migrate

SUPERUSER_COUNT=$(docker compose --env-file DealHub/.env -f DealHub/docker-compose.yml exec -T app python manage.py shell -c "from django.contrib.auth import get_user_model; User = get_user_model(); print(User.objects.filter(is_superuser=True).count());")


 if [ "$SUPERUSER_COUNT" = "0" ]; then
      SUPERUSER_PASSWORD=$(openssl rand -hex 16)
      docker compose --env-file DealHub/.env -f DealHub/docker-compose.yml exec -T app python manage.py shell -c "from django.contrib.auth import get_user_model; User = get_user_model(); User.objects.create_superuser(username='admin', password='$SUPERUSER_PASSWORD', email=None);"

      echo "Superuser admin created with password $SUPERUSER_PASSWORD"
      echo "Go to http://localhost:8000/admin/password_change/ and login with the superuser to change the password"
  fi

sort -u -t '=' -k 1,1 DealHub/.env DealHub/.env.example | sed '/^$/d' >DealHub/.env.temp && mv DealHub/.env.temp DealHub/.env

echo "DealHub has been updated to the latest version!"
echo "Please check the logs to make sure everything is running fine."