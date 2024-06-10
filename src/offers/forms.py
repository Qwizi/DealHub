from django import forms

from categories.models import Category
from offers.models import Offer


class CreateOfferForm(forms.ModelForm):
    title = forms.CharField(min_length=2, label="Tytuł")
    category = forms.ModelChoiceField(queryset=Category.objects.all(), empty_label="Wybierz kategorię", label="Kategoria")
    images = forms.CharField(widget=forms.Textarea(attrs={"style": "height: 250px;"}), min_length=2, label="Linki do zdjęć", help_text="Każdy link w nowej linii")
    description = forms.CharField(widget=forms.Textarea(attrs={"style": "height: 250px;"}), min_length=2, label="Opis")
    price = forms.DecimalField(min_value=0, label="Cena", decimal_places=2, max_digits=10, help_text="W PLN")

    class Meta:
        model = Offer
        fields = ["title", "category", "images", "description", "price"]