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
      puts "\nType a number to see a list of attractions and events in each of the following categories:"
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
    details(category, input.to_i)
  end

  def details(category, index)
    true_array = Attraction.all.select do |attraction|
      category == attraction.category
    end
    selection = true_array[index-1]
      puts "\n\nAttraction: #{selection.name}"
      puts "\nCategory: #{selection.category}"
      puts "\nDescription: #{selection.description}"
      puts "\nLocation: #{selection.location}"
      puts "\n\nType 'category' to go back to the list of categories."
      puts "When finished, type 'exit'"
  end

  def goodbye
    puts "Enjoy your visit!"
  end
end
