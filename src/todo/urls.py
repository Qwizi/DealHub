from django.urls import path

from todo.views import index


urlpatterns = [path("", index, name="todo-index")]
