import random
from time import sleep

import requests
from django.conf import settings
from django.contrib.auth import get_user_model
from django.core.management.base import BaseCommand
from requests import HTTPError

from categories.models import Category

User = get_user_model()


class Command(BaseCommand):
    help = 'Create offers with stock images from api'

    def get_stock_images(self, category_name: str):
        try:
            # 1
            # 2
            # curl -H "Authorization: G72Li9VijN0gSCPJARDynWSr4e8y1IsNpACafoo8FpThsKIWbOz3lpI8" \
            #   "https://api.pexels.com/v1/search?query=nature&per_page=1"
            url = f"https://api.pexels.com/v1/search?query={category_name}&per_page=5&locale=pl-PL"
            headers = {
                "Authorization": settings.PEXELS_API_KEY
            }
            response = requests.get(url, headers=headers)
            response.raise_for_status()
            return response.json()
        except HTTPError:
            return None

    def handle(self, *args, **options):
        categories_names = [
            "Komputery",
            "Telefony",
            "rtv i agd",
            "Uroda",
            "Moda",
            "Dom",
            "Sport",
            "Motoryzacja",
            "Kultura",
        ]
        users_names = [
            "Jan",
            "Kasia",
            "Piotr",
            "Ania",
            "Marek",
            "Zosia",
            "Tomek",
            "Asia",
            "Kuba",
            "Basia",
        ]
        users_surnames = [
            "Kowalski",
            "Nowak",
            "Wiśniewski",
            "Wójcik",
            "Kowalczyk",
            "Kamiński",
            "Lewandowski",
            "Zieliński",
            "Szymański",
            "Woźniak",
        ]
        users = []
        for i in range(10):
            self.stdout.write(f"Creating user: {users_names[i]} {users_surnames[i]}")
            user = User.objects.create_user(
                username=f"{users_names[i].lower()}{users_surnames[i].lower()}",
                first_name=users_names[i],
                last_name=users_surnames[i],
                email=f"{users_names[i].lower()}{users_surnames[i].lower()}@example.com",
                password="password",
            )
            users.append(user)
        categories = []
        for category in categories_names:
            self.stdout.write(f"Creating offers for category: {category}")
            category = Category.objects.create(name=category)
            categories.append(category)

        for i in range(50):
            category = random.choice(categories)
            user = random.choice(users)
            self.stdout.write(f"Creating offer for user: {user.username}")
            images = self.get_stock_images(category.name)
            print(images)
            if images:
                images_urls = [image["src"]["original"] for image in images["photos"]]
                images_str = "\n".join(images_urls)
                random.shuffle(images_urls)
                description = images["photos"][0]["alt"]
            else:
                images_str = "https://img.daisyui.com/images/stock/photo-1606107557195-0e29a4b5b4aa.jpg"
                description = "Opis oferty"
            offer = category.offers.create(
                title=f"Sprzedam przedmiot w {category.name}",
                author=user,
                images=images_str,
                description=description,
                price=float(random.randint(10, 1000))
            )
            self.stdout.write(f"Offer created: {offer.title}")

