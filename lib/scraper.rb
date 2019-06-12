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
      list_items = doc.css("#main div.content a").map{|attractions| attractions.text.strip}.sort
      #creates an array of attractions
      #used in CLI to list attractions
    end

    def self.urls
      list_items = Scraper.parse.css("#main div.content a").map{|attractions| "https://www.visitmelbourne.com"+"#{attractions.attr('href')}"}
      #creates an array of attraction urls to parse
      #used in parse_attraction_pages method to create hash
    end

    def self.url_parser #scrapes the second level. pulls the information about each attraction.
      Scraper.urls.sort.each_with_index do |url, i|
        doc = Nokogiri::HTML(open(url))
          name = doc.css(".sl-item h1").text
          category = doc.css(".tag-label").text
          description = doc.css("#overview p").text
          location = doc.css("span.address").text
          unless Attraction.sort_by_name.include?(name)
            Attraction.new(name, category, description, location)
          end
        end
      end

end
