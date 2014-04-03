#city_pop_class.rb

# ===============================
# Objective: to read a file listing the city, state and
# population of the largest cities in the U.S.  For a 
# given state, a list of large cities (in alphabetical 
# order) is produced along with their respective 
# populations.  If there are no large cities in that 
# state, an informative message should notify the user.

class Population
  
  def initialize(state)
    @cities = {}
    @file = File.open("citypop.txt")
    @file.each_line do |line|
      city, st, population = line.split(/\t/)
      if state == st
        @cities[city] = population.chomp
      end
    end
   unless @cities.empty?      
      puts "Top Cities in #{state}"
      puts "================="
      @cities.sort{|a,b| a[0]<=>b[0]}.each do |city, population|
        puts "#{city} (#{population})"
      end
    else
      puts "#{state} has no cities in the Top 40."
    end
  end
end

### This solution uses classes to solve, but in a poor way.
### No other methods aside from initialize and that method 
### is severely abused.  Do you remember the problems we 
### discussed in class?  