class Attraction

attr_accessor :category, :description, :location
@@all = []

def initialize(category = nil, description = nil, location = nil)
  @category, @description, @location = category, description, location
  @@all << self
end

def self.all
  @@all
end

end
