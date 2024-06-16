from django.urls import reverse
from django.contrib.auth.mixins import LoginRequiredMixin
from django.views.generic import CreateView
from offers.models import Offer
from django_htmx.http import HttpResponseClientRedirect 
from reviews.forms import CreateReviewForm
from reviews.models import Review


class CreateReviewView(LoginRequiredMixin, CreateView):
    model = Review
    form_class = CreateReviewForm

    def get_success_url(self):
        return reverse("offer_detail", kwargs={"pk": self.kwargs["pk"]})

    def form_valid(self, form):
        form.instance.author = self.request.user
        form.instance.review = Offer.objects.get(pk=self.kwargs["pk"])
        response = super().form_valid(form)
        if self.request.htmx:
            return HttpResponseClientRedirect(self.get_success_url())
        else:
            return response