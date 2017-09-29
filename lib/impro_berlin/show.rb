 class ImproBerlin::Show

   attr_accessor :month, :day, :name, :url, :price, :description, :location

   @all = []

   def initialize

   end

   def self.create_from_page(shows_array)
     #This should take array of shows and create new shows to display
     shows_array.each do |hash|
       Show.new(hash)
     end
   end

   def self.all
     @@all
   end
 end
