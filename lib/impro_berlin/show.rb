 class ImproBerlin::Show

   attr_accessor :month, :day, :name, :url, :price, :description, :location

   @all = []

   def initialize
     
   end

   def self.all
     @@all
   end
 end
