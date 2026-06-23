"""
urls.py
App-level routing for the Django search engine.
"""

from django.conf.urls import url
from . import views

# Defines URL pattern matchers to route index and search queries to views
urlpatterns = [
    url(r'search_results.html/$', views.search_results, name='search_results'),
    url(r'^$', views.index, name='index'),
]
