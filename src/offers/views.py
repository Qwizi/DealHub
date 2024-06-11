from django.contrib.auth.mixins import LoginRequiredMixin
from django.shortcuts import render
from django.urls import reverse_lazy
from django.views.generic import ListView, CreateView

from categories.models import Category
from offers.forms import CreateOfferForm
from offers.models import Offer

def offer_index(request):
    offers = Offer.objects.all()
    categories = Category.objects.all()
    return render(request, "offers/index.html", {"offers" :offers, "categories" :categories})
# Create your views here.


class OfferListView(ListView):
    model = Offer
    template_name = "offers/index.html"
    context_object_name = "offers"

    def get_queryset(self):
        category = self.request.GET.get('category', None)
        if category:
            return Offer.objects.filter(category_id=category).order_by('-created_at')
        else:
            return Offer.objects.all().order_by('-created_at')

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