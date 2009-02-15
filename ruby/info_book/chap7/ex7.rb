

def main
  answer = ("%04d" % rand(10000)).split(//)
  # p answer.join
  10.times do |n|
    print "guess? > "
    user = gets.chomp.split(//)
    hit = 0
    blow = 0
    answer.each_with_index{|a, ai|
      user.each_with_index{|u, ui|
        hit += 1 if a == u && ai == ui
        blow += 1 if a == u && ai != ui
      }
    }
    return 'you win!' if hit == 4
    puts "turn #{n+1} : hit = #{hit}, blow = #{blow}"
  end
  "you lose! answer = #{answer.join}"
end

puts main
