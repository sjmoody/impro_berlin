class ImproBerlin::Scraper
  def self.scrape_index_page
    #Scrape improv index page to get upcoming shows
    scraped_shows = []
    doc = Nokogiri::HTML(open("http://comedycafeberlin.com/#shows-calendar"))
    for i in 0..5
      show = ImproBerlin::Show.new
      show.month = doc.search("span.summary-thumbnail-event-date-month")[i].text
      show.day = doc.search("span.summary-thumbnail-event-date-day")[i].text
      show.name = doc.search("div.summary-title")[i].text.strip
      show.url = "http://comedycafeberlin.com" + doc.search("a.summary-thumbnail-container")[i].attr("href")
      scraped_shows.push(show)
    end
    scraped_shows
  end

  def self.scrape_details_page(show, details_url)
    if details_url =~ URI::regexp
      event_doc = Nokogiri::HTML(open(details_url))
      iframe_url = event_doc.search("iframe").attr("src").value
      iframe_details = self.scrape_eventbrite_page(show, iframe_url)
    else
      puts "Not valid URL: #{iframe_url}.  Exiting..."
      exit
    end

    show
  end

  def self.scrape_eventbrite_page(show, iframe_url)
    if iframe_url =~ URI::regexp
      doc = Nokogiri::HTML(open(iframe_url))
      show.price = doc.search("div.js-display-price").first.text.strip
      show.description = doc.search("div.js-xd-read-more-contents").first.text.strip
      show.location = doc.search("div.event-details__data")[1].text.strip
    else
      puts "Not valid URL: #{iframe_url}.  Exiting..."
      exit
    end

    show
  end
end
