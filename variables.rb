# Simple methods format purposes
def brk
  puts "============================"
end
def smbrk
  puts "----------------------------"
end

#############################
# STARTING THE DEMO

# Setting a global variable
$hero = "Underdog"
puts "Listing global for first time: #{$hero}"
brk


# Creating a class called Dog that we will use to create instances of dogs later
class Dog
   # a class variable to track number of dog objects created
    @@number_of_dogs = 0
  
  # when we create a new Dog object, we must specify a breed  
  def initialize(breed)
    @@number_of_dogs += 1
    @breed = breed  # setting the instance variable breed with value passed at initialization
    # printing this out to verify this happened...
    puts "#{@@number_of_dogs}. The global variable is #{$hero} and the breed is #{@breed}\n\n"
  end
  
  # a getter method for getting the value of the @name instance variable
  def name
    @name
  end
  
  # a setter method for assigning a value to the @name instance variable
  def name=(name)
    @name = name
    puts " This dog will be known as #{@name}"
  end
  
  # a method to overwrite the existing to_s method for Object so it is more informative
  def to_s
    @name || 'TBD'
  end

  # Ruby shortcuts for creating accessor methods
  attr_reader :breed
  attr_accessor :gender, :age
  
  # a class method to get the value of the class variable
  def self.number_of_dogs
    @@number_of_dogs
  end
    
  # an instance method to convert age to dog_years for a particular instance of dog
  def dog_years
    return nil if @age.nil?
    multiplier = 7
    multiplier * @age
  end
  
  # Just some testing ... do you know what will happen?
  puts "Trying to print @age: #{@age || 'not declared yet'}"
  puts "Trying to print global: #{$hero || 'out of scope'}"
  # puts "Trying to print multiplier: #{multiplier}"
  
end

# another method outside the Dog class
def default_age
  multiplier = 7
  6 * multiplier
end

# a local variable outside any method or class (technically part of 'main' ...)
mult_dog = 7

smbrk
# Time to create a Dog
honey = Dog.new("Beagle")
print Dog.number_of_dogs

# Set honey's name to "Honey"
honey.name = "Honey"
puts honey.breed  # print out breed to make sure everything's good

# Set honey's age and test it
honey.age = 8
puts "#{honey} is #{honey.age || default_age} years old"
puts "In dog years, that makes #{honey} #{honey.dog_years || default_age * mult_dog} years old."
# puts multiplier  ## if we ask what mutliplier is, it is unknown outside of the method default_age


brk
# Changing the global variable just to see how it influences behavior later
$hero = "Shoeshine Boy"
puts "Listing the global again: #{$hero}"
smbrk
# Creating a second dog object called 'underdog'
underdog = Dog.new("Mutt")
print Dog.number_of_dogs
underdog.name = $hero  # Setting the underdog object's name to the global variable
puts "#{underdog} is #{underdog.age || default_age} years old"
puts "In dog years, that makes #{underdog} #{underdog.dog_years || default_age * mult_dog} years old."
