#city_pop_2.rb

# ===============================
# Objective: to read a file listing the city, state and
# population of the largest cities in the U.S.  For a 
# given state, a list of large cities (in alphabetical 
# order) is produced along with their respective 
# populations.  If there are no large cities in that 
# state, an informative message should notify the user.


def get_population(state, *file)
  filename = ( file[0] ||= 'citypop_default.txt')

  cities = Hash.new
  pop_file = File.open(filename)
  pop_file.each_line do |line|
    city, st, population = line.split(/\t/)
    if state == st
      cities[city] = population.chomp
    end
  end
  pop_file.close

   unless cities.empty?      
      puts "Top Cities in #{state}"
      puts "================="
      cities.sort{|a,b| a[0]<=>b[0]}.each do |city, population|
        puts "#{city} (#{population})"
      end
    else
      puts "#{state} has no cities in the Top 40."
    end
end

get_population("CA", "citypop.txt") 
puts
get_population("PA", "citypop_1900.txt") 
puts
get_population("NH")
