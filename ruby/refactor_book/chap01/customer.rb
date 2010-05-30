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
      # レンタルポイントを加算
      frequent_renter_points += element.frequent_renter_points

      # このレンタルの料金を表示
      result += "\t" + element.movie.title + "\t" + element.charge.to_s + "\n"
    end
    # フッター行を追加
    result += "Amount owned is #{total_change}\n"
    result += "You earned #{frequent_renter_points} freqent renter points"
    result
  end

  def amount_for(rental)
    rental.charge
  end

  private

  def total_change
    @rentals.inject(0){|sum, rental| sum + rental.charge }
  end
end
