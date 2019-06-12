class CLI

  def call
    Scraper.url_parser
    welcome
    activity_list
  end

  def welcome
    puts "Welcome to Melbourne, Australia!"
  end

  def activity_list
      display_list
      number = nil
      while number != "exit"
      puts "Which activity or event would you like to know more about? (1-22)"
      puts "To see the list again, type 'list'"
      puts "To see the list separated into categories, type 'category'"
      puts "When finished, type 'exit'"
      number = gets.strip
      list_number = Attraction.sort_by_name.each_with_index{|attraction, i| i+1}
        if number.to_i == list_number
          puts details(number-1)
        elsif number == "list"
          display_list
        elsif number == "exit"
          goodbye
        else
          puts "Please enter a number 1-22:"
        end
      end
  end

  def display_list
    Attraction.sort_by_name.each_with_index do |attraction, i|
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
  end

  def goodbye
    puts "Enjoy your visit!"
  end
end
