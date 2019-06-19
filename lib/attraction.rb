class Attraction
attr_accessor :name, :category, :description, :location, :url
@@all = []

def initialize(name = nil, category = nil, description = nil, location = nil, url = nil)
  @name, @category, @description, @location, @url = name, category, description, location, url
  @@all << self
end

def self.all
  @@all
end

def self.sort_by_name
  name_array = Attraction.all.map do |attraction|
    attraction.name
  end
  name_array.sort
end

end
