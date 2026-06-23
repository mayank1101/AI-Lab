from __future__ import unicode_literals

from django.db import models

"""
models.py
Django models mapping directly to existing database tables.
These use `managed = False` since tables are populated and structured by Scrapy crawlers.
"""


class Ai(models.Model):
    """
    Model representing questions from the Artificial Intelligence StackExchange site.
    Maps to the 'AI' table in PostgreSQL.
    """
    tags = models.TextField(blank=True, null=True)
    questions = models.TextField()
    votes = models.TextField(blank=True, null=True)
    no_answers = models.TextField(blank=True, null=True)
    links = models.TextField()

    def __str__(self):
        return '%s %s %s %s %s' % (self.questions, self.links, self.votes, self.no_answers, self.tags)

    class Meta:
        managed = False
        db_table = 'AI'


class Askubuntu(models.Model):
    """
    Model representing questions from the AskUbuntu StackExchange site.
    Maps to the 'askUbuntu' table in PostgreSQL.
    """
    tags = models.TextField(blank=True, null=True)
    questions = models.TextField()
    votes = models.TextField(blank=True, null=True)
    no_answers = models.TextField(blank=True, null=True)
    links = models.TextField()

    def __str__(self):
        return '%s %s %s %s %s' % (self.questions, self.links, self.votes, self.no_answers, self.tags)

    class Meta:
        managed = False
        db_table = 'askUbuntu'


class Astronomy(models.Model):
    """
    Model representing questions from the Astronomy StackExchange site.
    Maps to the 'astronomy' table in PostgreSQL.
    """
    tags = models.TextField(blank=True, null=True)
    questions = models.TextField()
    votes = models.TextField(blank=True, null=True)
    no_answers = models.TextField(blank=True, null=True)
    links = models.TextField()

    def __str__(self):
        return '%s %s %s %s %s' % (self.questions, self.links, self.votes, self.no_answers, self.tags)

    class Meta:
        managed = False
        db_table = 'astronomy'
