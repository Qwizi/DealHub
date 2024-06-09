from django.shortcuts import render

from categories.models import Category
from offers.models import Offer

def offer_index(request):
    offers = Offer.objects.all()
    categories = Category.objects.all()
    return render(request, "offers/index.html", {"offers" :offers, "categories" :categories})
# Create your views here.
