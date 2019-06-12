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
      puts "Type a number to see a list of attractions and events in each category:"
  end

  def categories
    Attraction.sort_by_category.each_with_index do |attraction, i|
      puts "#{i+1}. #{attraction}"
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
