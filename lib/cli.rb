class CLI

  def call
    Scraper.url_parser
    welcome
    category_list
  end

  def welcome
    puts "\n\nWelcome to Melbourne, Australia!"
    puts "Here is a list of attraction categories. What would you like to do while you're here?"
  end

  def category_list
      puts "\n\nEnter a number to see attractions and events for each category:"
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
          puts "Or if finished, type 'exit'."
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
      elsif input == "back"
        category_list
      else
        puts "Please enter the corresponding number or type 'back' to see the category list:"
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
      puts "\n\nType 'back' to see the list of categories again."
      puts "Type 'exit' to exit."
      input = nil
      while input != "exit"
        input = gets.strip
        if input == "back"
          category_list
        elsif input == "exit"
          goodbye
        else
        puts "Please type 'back' or 'exit'"
      end
    end
  end

  def goodbye
    puts "\nEnjoy your visit!"
    exit
  end

end
