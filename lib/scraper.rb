require "open-uri"
require "nokogiri"
require "pry"

class Scraper

  BASE_URL = "https://www.visitmelbourne.com/regions/melbourne/things-to-do"

    def self.parse
      doc = Nokogiri::HTML(open(BASE_URL))
    end

    def self.urls
      list_items = Scraper.parse.css("#main div.content a").map{|attractions| "https://www.visitmelbourne.com"+"#{attractions.attr('href')}"}
      #creates an array of attraction urls to parse
      #used in url_parser method to create hash
    end

    def self.url_parser #scrapes the second level. pulls the information about each attraction.
      Scraper.urls.sort.each_with_index do |url, i|
        doc = Nokogiri::HTML(open(url))
          name = doc.css(".sl-item h1").text
          category = doc.css(".tag-label").text
          description = doc.css("#overview p").text
          location = doc.css("section.cm.cm-map span.address"").text
          unless Attraction.sort_by_name.include?(name)
            Attraction.new(name, category, description, location)
            if !Category.sort_by_name.include?(category)
            Category.new(category, name)
          end
        end
      end
    end

end
