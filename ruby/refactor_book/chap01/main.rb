require 'movie'
require 'rental'
require 'customer'
require 'price'

def main
  movies = [
            Movie.new('movie regular', Movie::REGULAR),
            Movie.new('movie new release', Movie::NEW_RELEASE),
            Movie.new('movie childrens', Movie::CHILDRENS),
           ]
  customer = Customer.new('Joe')
  movies.each do |movie|
    customer.add_rental(Rental.new(movie, 7))
  end
  puts customer.statement
end

main
