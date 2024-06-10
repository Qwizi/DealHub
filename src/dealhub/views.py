from django.shortcuts import render

from categories.models import Category
from offers.models import Offer


def index(request):
    categories = Category.objects.all()
    offers = Offer.objects.filter(is_active=True).order_by('-created_at')[:12]
    return render(request, 'index.html', {"categories": categories, "offers": offers})
