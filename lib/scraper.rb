require "open-uri"
require "nokogiri"
require "pry"

class Scraper

  BASE_URL = "https://www.visitmelbourne.com/regions/melbourne/things-to-do"

    def self.parse
      doc = Nokogiri::HTML(open(BASE_URL))
    end

    def self.new_attractions
      list_items = Scraper.parse.css("#main div.content a")
      list_items[0..9].each do |attraction|
        names = []
        names << attraction.text.strip
        urls = []
        urls << "https://www.visitmelbourne.com" + "#{attraction.attr('href')}"
        names.each do |name|
        unless Attraction.sort_by_name.include?(name)
            new_attraction = Attraction.new
            new_attraction.name = name
            urls.each do |url|
              new_attraction.url = url
            end
          end
        end
      end
    end

    def self.add_details(url)
      doc = Nokogiri::HTML(open(url))
      Attraction.all.each do |attraction|
        if attraction.url == url
          attraction.description = doc.css("#overview p").text
          attraction.location = doc.css("section.cm.cm-map span.address").text
          attraction.category = category = doc.css(".tag-label").text
        end
      end
    end

end
