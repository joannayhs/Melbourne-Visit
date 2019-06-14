class CLI

  def call
    Scraper.url_parser
    welcome
    category_list
    goodbye
  end

  def welcome
    puts "Welcome to Melbourne, Australia!"
    puts "Here is a list of attraction categories. What would you like to do while you're here?"
  end

  def category_list
      puts "\nType a number to see a list of attractions and events in each of the following categories:"
      categories
      number = nil
      while number != "exit"
        number = gets.strip
        if number.to_i.between?(1,Category.all.length)
          attraction_list(Category.sort_by_name[number.to_i - 1])
        elsif number == "exit"
          goodbye
        else
          puts "Please type a number between 1 and #{Category.all.length}:"
          puts "When finished, type 'exit'."
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
    input = nil
    while !input.to_i.between?(1,true_array.length)
      input = gets.strip
      if input.to_i.between?(1,true_array.length)
        details(category, input.to_i)
      else
        puts "Please enter a number between 1 and #{true_array.length}"
      end
    end
  end

  def details(category, index)
    true_array = Attraction.all.select do |attraction|
      category == attraction.category
    end
    selection = true_array[index-1]
      puts "\n\nAttraction: #{selection.name}"
      puts "Category: #{selection.category}"
      puts "\nLocation: #{selection.location}"
      puts "\nDescription: \n#{selection.description}"
      puts "\n\nType 'category' to go back to the list of categories."
      puts "When finished, type 'exit'"
      input = gets.strip
      if input == "category"
        category_list
      elsif input == "exit"
        goodbye
      else
        puts "Please type 'category' or 'exit'"
      end
  end

  def goodbye
    puts "Enjoy your visit!"
    CLI.exit
  end

end
