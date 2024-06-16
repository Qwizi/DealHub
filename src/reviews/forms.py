from django import forms
from reviews.models import Review


class CreateReviewForm(forms.ModelForm):
    content = forms.CharField(
        widget=forms.Textarea(attrs={"style": "height: 250px;"}),
        min_length=2,
        label="Tresc",
    )
    stars = forms.IntegerField(min_value=1, max_value=5, label="Ocena (1-5)")


    class Meta:
        model = Review
        fields = ["content", "stars"]