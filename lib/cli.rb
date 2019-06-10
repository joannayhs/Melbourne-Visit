class CLI

  def call
    welcome
    activity_list
  end

  def welcome
    puts "Welcome to Melbourne, Australia!"
  end

  def activity_list
    puts "Here is a list of the top attractions in the city:"
    number = nil
    display_list
    while number != "exit"
      puts "Which activity would you like to know more about? (1-22)"
      puts "To see the list again, type 'list'"
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

  def display_list
    Scraper.attractions.each_with_index do |activity, i|
      puts "#{i+1}. #{activity}"
    end
  end

  def goodbye
    puts "Enjoy your visit!"
  end
end
