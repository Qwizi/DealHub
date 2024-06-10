from urllib.parse import urlparse

from django import forms
from django.core.exceptions import ValidationError
from django.core.validators import URLValidator

from categories.models import Category
from offers.models import Offer


class CreateOfferForm(forms.ModelForm):
    title = forms.CharField(min_length=2, label="Tytuł")
    category = forms.ModelChoiceField(queryset=Category.objects.all(), empty_label="Wybierz kategorię", label="Kategoria")
    images = forms.CharField(widget=forms.Textarea(attrs={"style": "height: 250px;"}), min_length=2, label="Linki do zdjęć", help_text="Każdy link w nowej linii")
    description = forms.CharField(widget=forms.Textarea(attrs={"style": "height: 250px;"}), min_length=2, label="Opis")
    price = forms.DecimalField(min_value=0, label="Cena", decimal_places=2, max_digits=10, help_text="W PLN")

    def clean_images(self):
        images = self.cleaned_data.get('images')
        validator = URLValidator()
        valid_extensions = ['jpg', 'jpeg', 'png', 'gif']
        for url in images.split('\n'):
            try:
                validator(url)
                ext = urlparse(url).path.split('.')[-1]
                if ext.lower() not in valid_extensions:
                    raise ValidationError(f"{url} nie jest obrazkiem w formacie jpg, jpeg, png lub gif")
            except ValidationError:
                raise ValidationError(f"{url} nie jest poprawnym linkiem do obrazka")
        return images


    class Meta:
        model = Offer
        fields = ["title", "category", "images", "description", "price"]