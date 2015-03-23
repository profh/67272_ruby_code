class Person
  
  @@number_of_people = 0
  
  attr_reader :first_name, :last_name
  
  def self.number_of_people
    @@number_of_people
  end
  
  def cumulative_count
    return 'No people exist yet.' if @@number_of_people.zero?
    "#{@@number_of_people} #{(@@number_of_people == 1) ? 'person exists' : 'people exist'}"    
  end
  
  def initialize(first_name, last_name)
    @first_name, @last_name = first_name, last_name
    @@number_of_people += 1
  end
  
  def to_s
    #  "#{@first_name} #{@last_name}" is another possibility ... 
    [@first_name, @last_name].join(" ")
  end
  
end


num = Person.number_of_people
puts "#{num} people exist"
puts

profh = Person.new("Larry", "Heimann")
puts "Created #{profh}"
puts profh.cumulative_count
puts

puts Array.new(20, "-").join
patrick = Person.new("Patrick", "Stewart")
puts "Created #{patrick}"
puts patrick.cumulative_count
puts

puts Array.new(20, "-").join
puts profh.cumulative_count
avery = Person.new("Avery", "Brooks")
puts "Created #{avery}"
puts avery.cumulative_count
puts
puts Array.new(20, "-").join
puts profh.cumulative_count
puts "Double check time:"
final = Person.number_of_people
puts "#{final} people exist"

### OUTPUT ###
# >> 0 people exist
# >> 
# >> Created Larry Heimann
# >> 1 person exists
# >> 
# >> Created Patrick Stewart
# >> 2 people exist
# >> 
# >> Created Avery Brooks
# >> 3 people exist
# >> 
# >> Double check time:
# >> 3 people exist
