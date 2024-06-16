from django.contrib.auth.mixins import LoginRequiredMixin
from django.shortcuts import render
from django.urls import reverse_lazy
from django.views import View
from django_htmx.http import HttpResponseLocation

from django.views.generic import ListView, CreateView
from django.views.generic.detail import DetailView
from categories.models import Category
from offers.forms import CreateOfferForm
from offers.models import Offer
from reviews.forms import CreateReviewForm


def offer_index(request):
    offers = Offer.objects.all()
    categories = Category.objects.all()
    return render(
        request, "offers/index.html", {"offers": offers, "categories": categories}
    )


# Create your views here.


class OfferListView(ListView):
    model = Offer
    template_name = "offers/index.html"
    context_object_name = "offers"

    def get_queryset(self):
        category = self.request.GET.get("category", None)
        if category:
            return Offer.objects.filter(category_id=category).order_by("-created_at")
        else:
            return Offer.objects.all().order_by("-created_at")

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context["categories"] = Category.objects.all()
        return context


class CreateOfferView(LoginRequiredMixin, CreateView):
    model = Offer
    form_class = CreateOfferForm
    template_name = "offers/create_offer.html"
    success_url = reverse_lazy("offers_list")

    def form_valid(self, form):
        form.instance.author = self.request.user
        return super().form_valid(form)


class OfferDetailView(DetailView):
    model = Offer
    template_name = "offers/offer_detail.html"
    context_object_name = "offer"

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['reviews'] = self.object.review_set.all().order_by('-created_at')[:10]
        total_stars = self.object.review_set.count()
        for i in range(1, 6):
            context[f"number_of_{i}_stars"] = self.object.review_set.filter(stars=i).count()
            context[f"percentage_of_{i}_stars"] = int((context[f"number_of_{i}_stars"] / total_stars) * 100) if total_stars > 0 else 0
        print(context)
        context["create_review_form"] = CreateReviewForm()
        return context


class BuyOfferView(LoginRequiredMixin, View):
    model = Offer

    def post(self, request, pk):
        offer = Offer.objects.get(pk=pk)
        offer.buy()
        return HttpResponseLocation(reverse_lazy("offer_detail", kwargs={"pk": pk}))
