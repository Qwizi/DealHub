from django.urls import path
from offers.views import offer_index, OfferListView, CreateOfferView

urlpatterns = [
    path("", OfferListView.as_view(), name="offers_list"),
    path("create/", CreateOfferView.as_view(), name="create_offer")
]