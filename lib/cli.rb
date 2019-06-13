class CLI

  def call
    Scraper.url_parser
    welcome
    category_list
  end

  def welcome
    puts "Welcome to Melbourne, Australia!"
    puts "What would you like to do while you're here?"
  end

  def category_list
      categories
      puts "Type a number to see a list of attractions and events in each of the following categories:"
      number = nil
      while number != "exit"
        number = gets.strip
        attraction_list(Category.sort_by_name[number.to_i - 1])
      end
  end

  def categories
    Category.sort_by_name.each_with_index do |category, i|
      puts "#{i+1}. #{category}"
    end
  end

  def attraction_list(category)
    true_array = Attraction.all.select do |attraction|
      category == attraction.category
    end
    true_array.each_with_index do |attraction, i|
      puts "#{attraction.category}"
      puts "#{i + 1}. #{attraction.name}"
      puts "To see more information about any of these attractions, type the corresponding number:"
    end
  end

  def details(index)
    selection = Attraction.sort_by_name[index]
      puts "#{selection.name}\n"
      puts "#{selection.category}\n"
      puts "#{selection.description}\n"
      puts "#{selection.location}"
  end

  def goodbye
    puts "Enjoy your visit!"
  end
end
