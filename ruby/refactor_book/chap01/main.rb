require 'movie'
require 'rental'
require 'customer'
require 'price'

def main
  movies = [
            Movie.new('movie regular', RegularPrice.new),
            Movie.new('movie new release', NewReleasePrice.new),
            Movie.new('movie childrens', ChildrensPrice.new),
           ]
  customer = Customer.new('Joe')
  movies.each do |movie|
    customer.add_rental(Rental.new(movie, 7))
  end
  puts customer.statement
end

main
