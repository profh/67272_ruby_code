#city_pop_improved.rb

# ===============================
# Objective: to read a file listing the city, state and
# population of the largest cities in the U.S.  For a 
# given state, a list of large cities (in alphabetical 
# order) is produced along with their respective 
# populations.  If there are no large cities in that 
# state, an informative message should notify the user.


class Population
  
  # When initializing, set the file (default value given)
  def initialize(file="citypop.txt")
    @population_file = file
    @file_lines = Array.new
  end
  
  # Opportunity to reset file, but also need to reset file lines
  def population_file=(file)
    @population_file = file
    @file_lines = Array.new  # read_file won't work if not reset
  end
    
  # Main method the user will employ
  def get_pop_for(state)
   # read the file to get the data
   read_file
   
   # create a new hash to store the requested informatiom
   @cities = Hash.new
   # populate the hash with file data
   @file_lines.each do |line|
     city, st, population = line.split(/\t/)
     if state == st
       @cities[city] = population.chomp
     end
   end
   
   # print the output of the hash
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
  
  private
  # Read the contents of the file, if haven't done so already  
  def read_file
    if @file_lines.empty?
      @file = File.open(@population_file)
      @file_lines = @file.readlines()
    end
  end
  
end

# TEST
pop1 = Population.new
pop1.get_pop_for("CA")
puts
pop1.get_pop_for("TX")
puts
pop1.get_pop_for("PA")
puts 
pop1.get_pop_for("NC")
puts
pop1.population_file=("citypop_1900.txt")
pop1.get_pop_for("PA")
puts
pop1.get_pop_for("NC")
puts "---------------------------------"
puts
pop2 = Population.new("citypop_1900.txt")
pop2.get_pop_for("CA")
puts
pop2.get_pop_for("AK")

### This works, but is it really final?  The fact is that the
### get_pop_for method is too big and doing too many different
### things.  Can we refactor this code?  Of course we can...
