# -*- coding: utf-8 -*-

"""
pipelines.py
Consolidated item pipeline that writes scraped data to the PostgreSQL database.
"""

from sqlalchemy.orm import sessionmaker
from .DBmodel import db_connect, create_tables, AIDB, AskUbuntuDB, AstronomyDB


class StackExchangePipeline(object):
    """
    Main Scrapy pipeline for storing StackExchangeItems in PostgreSQL database.
    Dynamically routes items to the correct table based on the active spider's name.
    """

    def __init__(self):
        """
        Initializes the database engine, generates schema tables, and creates session factory.
        """
        engine = db_connect()
        create_tables(engine)
        self.Session = sessionmaker(bind=engine)

    def process_item(self, item, spider):
        """
        Processes Scrapy item and inserts it into database table corresponding to the active spider.
        Args:
            item (StackExchangeItem): Scraped item.
            spider (scrapy.Spider): Executed spider instance.
        Returns:
            StackExchangeItem: The processed item.
        """
        session = self.Session()
        
        # Determine database table by spider name
        if spider.name == 'ai_spider':
            db_item = AIDB(**item)
        elif spider.name == 'ubuntu':
            db_item = AskUbuntuDB(**item)
        elif spider.name == 'astro':
            db_item = AstronomyDB(**item)
        else:
            session.close()
            return item

        try:
            session.add(db_item)
            session.commit()
        except Exception:
            session.rollback()
            raise
        finally:
            session.close()

        return item
