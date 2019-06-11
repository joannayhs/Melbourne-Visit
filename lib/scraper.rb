require "open-uri"
require "nokogiri"
require "pry"

class Scraper

  BASE_URL = "https://www.visitmelbourne.com/regions/melbourne/things-to-do"

    def self.parse
      doc = Nokogiri::HTML(open(BASE_URL))
    end

    def self.attractions #gets the surface level of each activity to create the output list.
      doc = Scraper.parse
      list_items = doc.css("#main div.content a").map{|attractions| attractions.text.strip}
      #creates an array of attractions
      #used in CLI to list attractions
    end

    def self.urls
      list_items = Scraper.parse.css("#main div.content a").map{|attractions| "https://www.visitmelbourne.com"+"#{attractions.attr('href')}"}
      #creates an array of attraction urls to parse
      #used in parse_attraction_pages method to create hash
    end

    def self.url_hasher #scrapes the second level. pulls the information about each activity.
      Scraper.urls.each do |url|
        doc = Nokogiri::HTML(open(url)) #creates new key value pairs in the hash.
          category = doc.css(".tag-label").text
          description = doc.css("#overview p").text
          location = doc.css("span.address").text
          Attraction.new(category, description, location)
      end
    end

end
