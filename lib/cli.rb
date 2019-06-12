class CLI

  def call
    welcome
    activity_list
  end

  def welcome
    puts "Welcome to Melbourne, Australia!"
  end

  def activity_list
    puts "Would you like to see a list of the top attractions and current events happening in the city? (Y/N)"
    input = gets.strip.upcase
    if input == "Y"
      display_list
      number = nil
      while number != "exit"
      puts "Which activity or event would you like to know more about? (1-22)"
      puts "To see the list again, type 'list'"
      puts "To see the list separated into categories, type 'category'"
      puts "When finished, type 'exit'"
      number = gets.strip
        if number == "hello"
          puts "activity"
        elsif number == "list"
          display_list
        elsif number == "exit"
          goodbye
        else
          puts "Please enter a number 1-22:"
        end
      end
    end
  end

  def display_list
    Attraction.all.each_with_index do |activity, i|
      puts "#{i+1}. #{activity.name}"
    end
  end


  def category

  end

  def goodbye
    puts "Enjoy your visit!"
  end
end
