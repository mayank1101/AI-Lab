# -*- coding: utf-8 -*-

"""
items.py
Defines the Scrapy items for data serialization and loading.
"""

import scrapy


class StackExchangeItem(scrapy.Item):
    """
    Standardized container class for scraped StackExchange question data.
    These fields map to database columns in PostgreSQL.
    """
    links = scrapy.Field()       # URL link to the question
    questions = scrapy.Field()   # Title text of the question
    votes = scrapy.Field()       # Total vote count of the question
    no_answers = scrapy.Field()  # Total number of answers provided
    tags = scrapy.Field()        # String list of question tags
