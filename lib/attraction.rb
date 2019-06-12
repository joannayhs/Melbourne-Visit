class Attraction

attr_accessor :name, :category, :description, :location
@@all = []

def initialize(name = nil, category = nil, description = nil, location = nil)
  @name, @category, @description, @location = name, category, description, location
  @@all << self
end

def self.all
  @@all
end


def self.sort_by_category
  category_array = Attraction.all.map do |attraction|
     attraction.category
  end
  category_array.sort
end

end
