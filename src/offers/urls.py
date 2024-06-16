from django.urls import path
from offers.views import BuyOfferView, OfferDetailView, offer_index, OfferListView, CreateOfferView
from reviews.views import CreateReviewView

urlpatterns = [
    path("", OfferListView.as_view(), name="offers_list"),
    path("create/", CreateOfferView.as_view(), name="create_offer"), 
    path("<int:pk>/", OfferDetailView.as_view(), name="offer_detail"),
    path("<int:pk>/review", CreateReviewView.as_view(), name="offer_create_review"),
    path("<int:pk>/buy", BuyOfferView.as_view(), name="offer_buy"),
]