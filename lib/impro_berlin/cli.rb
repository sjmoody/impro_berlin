# Our CLI Controller
class ImproBerlin::CLI
  def call
    list_shows
    menu
    goodbye
  end

  def list_shows
    puts "Upcoming shows in Berlin:"
    #Todo: get more than one show
    @shows = ImproBerlin::Scraper.scrape_index_page #array of shows
    @shows.each.with_index(1) do |event, i|
       puts "#{i}. #{event.name} - #{event.month} - #{event.day}"
     end
  end



  def menu
    input = nil
    while input != 'exit'
      puts "Enter the number of the show you'd like more info on or type exit to exit:"
      input = gets.strip.downcase
      selection = input.to_i
      if selection > 0 && selection < @shows.length + 1
        show = @shows[selection-1] #declare target show
        show_details = ImproBerlin::Scraper.scrape_details_page(show, show.url) #call details scraper to get more info.  I should assign this to obj but not sure best pattern
        show.location.gsub! /\t/, ''
        show.location.gsub! /\View Map/, ''
        puts "More info on this show: \n#{show.name}\n#{show.price}\n#{show.month} #{show.day} @ #{show.location}"
        puts "Description: \n#{show.description} \nGet your ticket here:\n#{show.url}"

      elsif input == "list"
        list_shows
      else
        puts "Save the improv for the show! Try a valid number, or list or exit."
      end
    end
  end

  def goodbye
    puts "Come back tomorrow for more shows"
  end
end
