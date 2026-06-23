"""
ubuntu_spider.py
Scrapy spider to scrape tags, questions, and stats from http://askubuntu.com/.
"""

import scrapy
from scrapy.selector import Selector
from scrapy.loader import ItemLoader
from crawlers.items import StackExchangeItem
from scrapy.http import HtmlResponse
from bs4 import BeautifulSoup
import re


class UbuntuSpider(scrapy.Spider):
    """
    Spider class that navigates the AskUbuntu StackExchange site,
    extracts pages, traverses question tags, and scrapes question metadata.
    """
    name = 'ubuntu'
    start_urls = ['http://askubuntu.com/',]

    def parse(self, response):
        """
        Base parser: extracts the tags section link and schedules request.
        """
        href = response.xpath('//div[@id="explore-tags"]/a[contains(@href, "/tags")]/@href').extract_first()
        yield scrapy.Request(response.urljoin(href), callback=self.get_all_tags)

    def get_all_tags(self, response):
        """
        Extracts individual tag links from the tags page list and scrapes each tag category.
        Traverses pagination to get subsequent tag listing pages.
        """
        for href in response.xpath('//div[@id="tags_list"]/table[@id="tags-browser"]/tr/td/a[contains(@href, "/questions/tagged/")]/@href').extract():
            if href is not None:
                url = response.url
                new_url = url[:21] + href[1:]
                yield scrapy.Request(new_url, callback=self.get_all_data)

        # Retrieve next page of tags list
        next_page = response.xpath('//div[@id="tags_list"]/div[@class="pager fr"]/a[contains(@rel, "next")]/@href').extract_first()
        if next_page is not None:
            yield scrapy.Request(response.urljoin(next_page), callback=self.get_all_tags)

    def get_all_data(self, response):
        """
        Extracts questions list on a tag page, parses metadata for each question,
        loads it into StackExchangeItem container, and paginates through tag questions.
        """
        bsObj = BeautifulSoup(response.body, "lxml")
        id_list = []
        
        # Scrape question summary IDs
        for tags in bsObj.findAll("div", {"id": re.compile("^question(|-|)summary(|-|)[0-9]{2,4}")}):
            id_list.append(tags["id"])
            
        for ids in id_list:
            load = ItemLoader(StackExchangeItem(), response=response)
            load.add_xpath('links', '//div[@id="questions"]/div[@id="{0}"]/div[@class="summary"]/h3/a[contains(@href, "/questions")]/@href'.format(ids))
            load.add_xpath('questions', '//div[@id="questions"]/div[@id="{0}"]/div[@class="summary"]/h3/a/text()'.format(ids))
            load.add_xpath('votes', '//div[@id="questions"]/div[@id="{0}"]/div[@class="statscontainer"]/div[@class="stats"]/div[@class="vote"]/div[@class="votes"]/span[@class="vote-count-post "]/strong/text()'.format(ids))
            load.add_xpath('no_answers', '//div[@id="questions"]/div[@id="{0}"]/div[@class="statscontainer"]/div[@class="stats"]/div[@class="status answered"]/strong/text()'.format(ids))
            load.add_xpath('tags', '//div[@id="questions"]/div[@id="{0}"]/div[@class="summary"]/div[contains(@class, "tags t-")]/a[contains(@class,"post-tag")]/text()'.format(ids))
            yield load.load_item()

        # Paginate through questions list
        next_page = response.xpath('//div[@id="mainbar"]/div[@class="pager fl"]/a[contains(@rel,"next")]/@href').extract_first()
        if next_page is not None:
            url = response.url
            new_url = url[:21] + next_page[1:]
            yield scrapy.Request(new_url, callback=self.get_all_data)
