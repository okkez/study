require 'movie'
require 'rental'
require 'customer'

def main
  movie = Movie.new('movie', Movie::REGULAR)
  customer = Customer.new('Joe')
  customer.add_rental(Rental.new(movie, 7))
  puts customer.statement
end

main
