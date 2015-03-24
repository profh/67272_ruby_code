#city_pop_1.rb

# ===============================
# Objective: to read a file listing the city, state and
# population of the largest cities in the U.S.  For a 
# given state, a list of large cities (in alphabetical 
# order) is produced along with their respective 
# populations.  If there are no large cities in that 
# state, an informative message should notify the user.


  filename = ARGV[0] || 'citypop_default.txt'
  state = ARGV[1] || "CA"
  # puts filename
  
  # Read the file and close it
  population_file = File.new(filename, 'r')
  file_lines = population_file.readlines()
  population_file.close()
  
  # Looking at some of this to understand it better
  puts "================="
  puts "Behind the Scenes"
  puts "================="
  puts
  puts "path of population_file: " + filename
  puts "class of population_file: " + population_file.class.to_s
  puts "class of file_lines: " + file_lines.class.to_s
  puts
  puts "L1: " + file_lines[0]
  puts "L2: " + file_lines[1]
  puts "L3: " + file_lines[2]
  puts "L4: " + file_lines[3]
  puts
  
  # Now to do some real work with the file
  cities = Hash.new
  file = File.open(filename)
  file.each_line do |line|
    city, st, population = line.split(/\t/)
    if state == st
      cities[city] = population.chomp
    end
  end
  
  unless cities.empty?      
     puts "Top Cities in #{state}"
     puts "================="
     cities.sort{|a,b| a[0]<=>b[0]}.each do |city, population|
       puts "#{city} (#{population})"
     end
     puts
   else
     puts "#{state} has no cities in the Top 40."
     puts
   end

  


