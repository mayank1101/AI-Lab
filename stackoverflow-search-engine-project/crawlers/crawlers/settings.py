# -*- coding: utf-8 -*-

BOT_NAME = 'crawlers'

SPIDER_MODULES = ['crawlers.spiders']
NEWSPIDER_MODULE = 'crawlers.spiders'

# Obey robots.txt rules
ROBOTSTXT_OBEY = True

# Database connection configuration
DATABASE = {
    'drivername' : 'postgresql',
    'host' : 'localhost',
    'port' : '5432',
    'username' : 'mayank',
    'password' : '12345',
    'database' : 'searchEngine'
}

# Configure item pipelines
ITEM_PIPELINES = {
    'crawlers.pipelines.StackExchangePipeline': 300,
}
