"""
form.py
Defines form classes for user query data validation.
"""

from django import forms


class SearchForm(forms.Form):
    """
    Search form to validate query inputs. 
    Accepts text fields up to 100 characters.
    """
    search_field = forms.CharField(label='Search', required=False, max_length=100)
