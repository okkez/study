# -*- coding: utf-8 -*-
class Customer
  attr_reader :name

  def initialize(name)
    @name = name
    @rentals = []
  end

  def add_rental(arg)
    @rentals << arg
  end

  def statement
    total_amount, frequent_renter_points = 0, 0
    result = "Rental Record for #{@name}\n"
    @rentals.each do |element|
      # このレンタルの料金を表示
      result += "\t" + element.movie.title + "\t" + element.charge.to_s + "\n"
    end
    # フッター行を追加
    result += "Amount owned is #{total_change}\n"
    result += "You earned #{total_frequent_renter_points} freqent renter points"
    result
  end

  def html_statement
    result = "<h1>Rentals for <em>#{@name}</em></h1><p>\n"
    @rentals.each do |element|
      # このレンタルの料金を表示
      result += "\t" + element.movie.title + ": " + element.charge.to_s + "<br>\n"
    end
    # フッターを追加
    result += "<p>You owe <em>#{total_charge}</em><p>\n"
    result += "On this rental you earned " +
      "<em>#{total_frequent_renter_points}</em> " +
      "frequent renter points<p>"
    result
  end

  def amount_for(rental)
    rental.charge
  end

  private

  def total_change
    @rentals.inject(0){|sum, rental| sum + rental.charge }
  end

  def total_frequent_renter_points
    @rentals.inject(0){|sum, rental| sum + rental.frequent_renter_points }
  end
end
