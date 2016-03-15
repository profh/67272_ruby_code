#city_pop_refactored.rb

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
    @cities = Hash.new
  end

  # Create some getters and setters
  attr_accessor :state
  attr_reader :population_file
  attr_reader :file_lines
  attr_reader :cities

  # Opportunity to reset file with custom setter, but also need to reset file lines
  def population_file=(file)
    @population_file = file
    @file_lines = Array.new  # read_file won't work if not reset
  end

  # Main method the user will employ
  def get_pop(st=self.state)
    self.state = st            # set the state if something else passed to method
    read_file                  # read the file to get the data
    find_cities_for_state(st)  # parse the data
    print_cities               # print results
  end

  # Bringing back that functionality from the very first pass...  
  def peek_into_file(lines=4)
    read_file if file_lines.empty?
    puts "a peek into the file: " + population_file
    puts "------------------------------------------------"
    lines.times{|i| puts "L#{i+1}: #{file_lines[i]}"}
  end
  
  def find_cities_for_state(st)
    @cities = Hash.new
    self.file_lines.each do |line|
      city, state, population = line.split(/\t/)
      cities[city] = population.chomp if state == st
    end
  end
  
  private
  def read_file
    file = File.open(@population_file)
    @file_lines = file.readlines()
  end
  


  def print_cities
    unless cities.empty? 
      sort_cities_alphabetically    # sort before printing
      print_header 
      list_cities
    else
      puts "#{state} has no cities in the Top 40."
    end
  end
  
  def sort_cities_alphabetically
    # @cities = @cities.sort{|a,b| a[0]<=>b[0]}      # older C syntax
    cities = self.cities.sort_by{ |city, pop| city }  # use Ruby syntax
  end
  
  def sort_cities_by_population
    # population comes as string, so have to strip commas and convert to integer
    cities = self.cities.sort_by{ |city, pop| pop.gsub(/,/,"").to_i }.reverse
  end
  
  def print_header
    puts "Top Cities in #{state}"
    puts "================="
  end
  
  def list_cities
    cities.each { |city, population| puts "#{city} (#{population})" } 
  end

end






## RUNNING THE CODE...

pop1 = Population.new
pop1.state = "CA"
pop1.get_pop
puts        
pop1.get_pop("TX")
puts        
pop1.get_pop("PA")
puts        
pop1.get_pop("NC")
puts
pop1.get_pop("NH")
puts "---------------------------------"
puts ""
pop1.population_file=("citypop_1900.txt")
pop1.peek_into_file
puts
pop1.get_pop("PA")
puts
pop1.state = "NC"
pop1.get_pop
puts "---------------------------------"
puts ""
pop2 = Population.new("citypop_1900.txt")
pop2.get_pop("CA")
puts
pop2.get_pop("AK")
