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
      puts "Type a number to see a list of attractions and events in each of the following categories:\n"
      number = nil
      while number != "exit"
        number = gets.strip
        if number.to_i.between?(1,Category.all.length)
          attraction_list(Category.sort_by_name[number.to_i - 1])
        elsif number == "exit"
          goodbye
        else
          puts "Please type a number between 1 and 14:"
        end
      end
  end

  def categories
    Category.sort_by_name.each_with_index do |category, i|
      puts "#{i+1}. #{category}"
    end
  end

  def attraction_list(category)
    puts "\n#{category}"
    true_array = Attraction.all.select do |attraction|
      category == attraction.category
    end
    true_array.each_with_index do |attraction, i|
      puts "\n#{i + 1}. #{attraction.name}"
    end
    puts "\nTo see more information about any of these attractions, type the corresponding number:"
    input = gets.strip
    details(input)
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
