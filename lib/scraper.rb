require "pry"
require "open-uri"
require "nokogiri"

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
      list_items = Scraper.parse.css("div.attractions-attraction-overview-pois-PoiInfo__info--239IR>div div:nth-child(2) a.attractions-attraction-overview-pois-PoiInfo__name--SJ0a4").map{|attractions| "https://www.tripadvisor.com"+"#{attractions.attr('href')}"}
      #creates an array of attraction urls to parse
      #used in parse_attraction_pages method to create hash
    end

    def self.url_hasher #scrapes the second level. pulls the information about each activity.
      attractions = {
        :title => [],
        :location => [],
        :about => [],
      }

      Scraper.urls.each do |url|
        doc = Nokogiri::HTML(open(url)) #creates new key value pairs in the hash.
          attractions[:title] << doc.css("#HEADING").text #title
          attractions[:location] << doc.css("div.contactInfo span[class='textAlignWrapper address']").text #location
      end
      attractions #this hash will be passed into a method in the Attraction class
    end

end
