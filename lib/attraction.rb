class Attraction
attr_accessor :category, :description, :location
@@all = []

def iniitalize(category = nil, description = nil, location = nil)
  @category, @description, @location = category, description, location
  @@all << self
end

def self.create_from_hash(hash)
  Scraper.url_hasher.each do |key, value|
    value.each do |info|
      self.send("#{key}=", info)
      self.save
    end
  end
end

def self.all
  @@all
end

def save
  @@all << self
end

end
