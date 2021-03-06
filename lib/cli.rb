class CLI

  def call
    Scraper.new_attractions
    welcome
    attraction_list
  end

  def welcome
    puts "\n\nWelcome to Melbourne, Australia!"
    puts "Here is a list of the top attractions. What would you like to do while you're here?"
  end

  def attraction_list
      puts "\n\nEnter a number to see more information about each attraction:"
      attractions
      number = nil
      while number != "exit"
        number = gets.strip
        if number.to_i.between?(1,Attraction.all.length)
          attraction_details(number.to_i - 1)
        elsif number == "exit"
          goodbye
        else
          puts "Please type a number between 1 and #{Attraction.all.length}:"
          puts "Or if finished, type 'exit'."
        end
      end
  end

  def attractions
    Attraction.sort_by_name.each_with_index do |attraction, i|
     puts "#{i + 1}. #{attraction}"
   end
  end


  def attraction_details(input)
    Attraction.all.each do |attraction|
      if attraction.name == Attraction.sort_by_name[input]
        Scraper.add_details(attraction.url) unless attraction.description != nil
        puts "\n\nAttraction: #{attraction.name}"
        puts "Category: #{attraction.category}"
        puts "\nLocation: #{attraction.location}"
        puts "\nDescription: \n#{attraction.description}"
        puts "\n\nType 'back' to see the list of attractions again."
        puts "Type 'exit' to exit."
      end
    end
      input = nil
      while input != "exit"
        input = gets.strip
        if input == "back"
          attraction_list
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
