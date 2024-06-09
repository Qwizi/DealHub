from django.urls import path
from offers.views import offer_index

urlpatterns = [
    path("", offer_index, name="offer-index")
]