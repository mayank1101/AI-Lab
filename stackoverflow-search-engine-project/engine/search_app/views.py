"""
views.py
Contains Django search views that handle queries, run Postgres-native 
fulltext search vectors, and format/render search result templates.
"""

from django.shortcuts import render
from django.http import HttpResponse, Http404
from .models import Astronomy, Ai, Askubuntu
from django.contrib.postgres.search import SearchVector


def index(request):
    """
    Renders the landing search dashboard page.
    """
    return render(request, 'search_app/search.html')


def search_results(request):
    """
    Handles GET query requests, filters results by site category, executes a
    SearchVector search query in Postgres, and maps it to a list of QueryData results.
    """
    data_list = []
    try:
        # Check target forum option
        if request.GET['val'] == 'astro':
            query = request.GET['q']
            # SearchVector queries 'questions' index in postgres
            astronomyObj = Astronomy.objects.annotate(search=SearchVector('questions')).filter(search=query)
            for obj in astronomyObj:
                data_list.append(QueryData(
                    obj.questions[2:len(obj.questions)-2], 
                    "http://astronomy.stackexchange.com/" + obj.links[1:len(obj.links)-2],
                    obj.tags[1:len(obj.tags)-1], 
                    obj.votes, 
                    obj.no_answers
                ))
            context = {'astronomyObj': astronomyObj, 'query': request.GET['q'], 'data_list': data_list}
            
        elif request.GET['val'] == 'ai':
            query = request.GET['q']
            # SearchVector queries 'questions' index in postgres
            aiObj = Ai.objects.annotate(search=SearchVector('questions')).filter(search=query)
            for obj in aiObj:
                data_list.append(QueryData(
                    obj.questions, 
                    "http://ai.stackexchange.com/" + obj.links[1:len(obj.links)-2],
                    obj.tags[1:len(obj.tags)-1], 
                    obj.votes, 
                    obj.no_answers
                ))
            context = {'aiObj': aiObj, 'query': request.GET['q'], 'data_list': data_list}
            
        elif request.GET['val'] == 'ubuntu':
            query = request.GET['q']
            # SearchVector queries 'questions' index in postgres
            ubuntuObj = Askubuntu.objects.annotate(search=SearchVector('questions')).filter(search=query)
            for obj in ubuntuObj:
                data_list.append(QueryData(
                    obj.questions, 
                    "http://askubuntu.com/" + obj.links[1:len(obj.links)-2],
                    obj.tags[1:len(obj.tags)-1], 
                    obj.votes, 
                    obj.no_answers
                ))
            context = {'ubuntuObj': ubuntuObj, 'query': request.GET['q'], 'data_list': data_list}
            
    except (Astronomy.DoesNotExist, Ai.DoesNotExist, Askubuntu.DoesNotExist):
        raise Http404("Question does not exist")
        
    return render(request, 'search_app/search_results.html', context)


class QueryData(object):
    """
    DTO class representing a formatted search result item.
    Cleans up string list bracket artifacts (e.g. ['tag']) before rendering to HTML.
    """

    def __init__(self, question, link, tags, votes, noAnswers):
        self.question = question
        self.link = link
        self.tags = tags
        self.votes = votes
        self.noAnswers = noAnswers
        
        # Clean bracket and slice characters from raw crawled datasets
        if self.noAnswers is not None:
            self.noAnswers = self.noAnswers[1:len(self.noAnswers)-1]
        if self.votes is not None:
            self.votes = self.votes[1:len(self.votes)-1]
