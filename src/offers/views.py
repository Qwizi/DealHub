from django.shortcuts import render

from offers.models import Offer

def offer_index(request):
    offers = Offer.objects.all()
    
    return render(request, "offers/index.html", {"offers" : offers})
# Create your views here.
