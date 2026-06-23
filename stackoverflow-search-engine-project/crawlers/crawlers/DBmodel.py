"""
DBmodel.py
Contains SQLAlchemy ORM model definitions for StackExchange sites tables 
(Artificial Intelligence, askUbuntu, and Astronomy) and database connection setup.
"""

from sqlalchemy import create_engine, Column, Integer, Text
from sqlalchemy.engine.url import URL
from sqlalchemy.ext.declarative import declarative_base
from . import settings

# Base class for SQLAlchemy declarative models
DeclarativeBase = declarative_base()


def db_connect():
    """
    Establishes connection to the PostgreSQL database using settings defined in Scrapy config.
    Returns:
        sqlalchemy.engine.Engine: Connection engine instance.
    """
    return create_engine(URL(**settings.DATABASE))


def create_tables(engine):
    """
    Generates target database tables (AI, askUbuntu, astronomy) if they do not already exist.
    Args:
        engine (sqlalchemy.engine.Engine): Connection engine instance.
    """
    return DeclarativeBase.metadata.create_all(engine)


class AIDB(DeclarativeBase):
    """
    SQLAlchemy model representing crawled questions from 'ai.stackexchange.com'.
    """
    __tablename__ = "AI"
    id = Column('id', Integer, primary_key=True)
    tags = Column('tags', Text, nullable=True)
    questions = Column('questions', Text, nullable=False)
    votes = Column('votes', Text, nullable=True)
    no_answers = Column('no_answers', Text, nullable=True)
    links = Column('links', Text, nullable=False)


class AskUbuntuDB(DeclarativeBase):
    """
    SQLAlchemy model representing crawled questions from 'askubuntu.com'.
    """
    __tablename__ = "askUbuntu"
    id = Column('id', Integer, primary_key=True)
    tags = Column('tags', Text, nullable=True)
    questions = Column('questions', Text, nullable=False)
    votes = Column('votes', Text, nullable=True)
    no_answers = Column('no_answers', Text, nullable=True)
    links = Column('links', Text, nullable=False)


class AstronomyDB(DeclarativeBase):
    """
    SQLAlchemy model representing crawled questions from 'astronomy.stackexchange.com'.
    """
    __tablename__ = "astronomy"
    id = Column('id', Integer, primary_key=True)
    tags = Column('tags', Text, nullable=True)
    questions = Column('questions', Text, nullable=False)
    votes = Column('votes', Text, nullable=True)
    no_answers = Column('no_answers', Text, nullable=True)
    links = Column('links', Text, nullable=False)
