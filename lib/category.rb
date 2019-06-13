class Category
  attr_accessor :name, :attraction
  @@all = []

  def initialize(name, attraction)
    @name, @attraction = name, attraction
    @@all << self
  end

  def self.all
    @@all
  end

  def self.sort_by_name
    category_names = Category.all.map do |category|
      category.name
    end
    category_names.sort
  end

end
