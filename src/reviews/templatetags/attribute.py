from django import template

register = template.Library()


@register.filter
def get_attribute(value, arg):
    return getattr(value, arg)