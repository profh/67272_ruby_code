# Examples: looking at classes and ancestors
  5.class                     # => Fixnum
  5.class.ancestors           # => [Fixnum, Integer, Numeric, Comparable, Object, Kernel, BasicObject]

  "Quack".class               # => String
  "Quack".class.ancestors     # => [String, Comparable, Object, Kernel, BasicObject]

  [1,2,3].class               # => Array
  [1,2,3].class.ancestors     # => [Array, Enumerable, Object, Kernel, BasicObject]
 
  d = class Duck; self; end;  # making a quick class
  daffy = Duck.new            # making an instance of that class
  d.class                     # => Class
  d.class.ancestors           # => [Class, Module, Object, Kernel, BasicObject]
  daffy.class                 # => Duck
  daffy.class.ancestors       # => [Duck, Object, Kernel, BasicObject]


# Note that everything -- integers, arrays, strings, classes -- are part of Object
  5.kind_of? Object           # => true
  "Quack".kind_of? Object     # => true
  [1,2,3].kind_of? Object     # => true
  d.is_a? Object              # => true
  daffy.is_a? Object          # => true
  # --------------------
  daffy.instance_of? Duck     # => true
  daffy.instance_of? Object   # => false

# Object receive messages
  "quack".send :upcase        # => "QUACK"
  5.send :+, 9                # => 14
  [1,2,3].send :nil?          # => false
  d.send :class               # => Class
  daffy.send :class           # => Duck
  
# Object responds to messages
  "quack".respond_to? :length # => true
  5.respond_to? :+            # => true


###############################################
#####  Example of the pen and the scribe  #####
###############################################

  # create a pen object
  pen = Object.new      # => #<Object:0x007f8f3c0ca378>
  
  # add a method to the pen
  def pen.to_s          # !> previous definition of to_s existed and we are overwriting it
    "A trusty pen"
  end
  # see that this method works as expected
  pen.send :to_s        # => "A trusty pen"
  pen.to_s              # => "A trusty pen"
  pen                   # => A trusty pen (the to_s method served as the object's name now)
  
  # let's start writing with our pen...
  # pen.write "nunqeh Terran" 
  ## => NoMethodError: undefined method `write' for A trusty pen:Object
  
  # fine, then let's add a method to this pen object so it can write
  def pen.write(words)
    puts words
  end
  
  pen.write "nunqeh Terran" 
  # => nil >> nunqeh Terran
  pen.write pen             
  # => nil >> A trusty pen
  
  # let's make the pen a blue ink pen (b/c blue is an awesome color...)
  # pen.ink_color = "Blue"  
  ## => NoMethodError: undefined method `ink_color' for A trusty pen:Object
  
  # okay, let's define the method ink_color for the pen object
  def pen.ink_color= color
    @ink_color = color
  end
  
  # now set the color to blue
  pen.ink_color = "Blue"    # => "Blue"
  
  # let's update to_s to add in the color
  def pen.to_s              # !> method redefined; discarding old to_s
    "A trusty #{@ink_color.downcase} pen" 
  end
  
  # verify that it works
  p pen.send :to_s            # => "A trusty blue pen"
  
  # writing a method that adds 'sparkles' to words to demo implicit receivers
  def pen.sparkly_write words
    write "*;. #{words} *;.*" # note the implicit receiver
  end
  
  pen.sparkly_write "Sparkles! (sort of)"  
  ## => nil >> *;. Sparkles! (sort of) *;.*
  pen.sparkly_write pen                    
  ## => nil >> *;. A trusty blue pen *;.*
  
  # create a method to write html
  def pen.html_write words
    if @ink_color
      write "<p style=\"color: #{@ink_color.downcase};\">#{words}</p>"
      # sorry for adding the color style right in the p tag but works for a demo...
    else
      write "<p>#{words}</p>"
    end 
  end
  
  # now try this method out...
  pen.html_write "Sorry Lizzie for the embedded style" 
  # => nil >> <p style="color: Blue;">Sorry Lizzie for the embedded style</p>
  
  # time for a break in the action
  puts Array.new(20, "-").join
  puts
  
  # create a scribe class who will actually use the pen object we created
  class Scribe 
    def initialize pen
      # a scribe needs almost by definition a pen, quill, etc.
      @pen = pen  
      # a list of items we want the scribe to record
      @list = Array.new 
    end
    
    # Getters and setters manually...
    # def list
    #   @list
    # end
    # 
    # def pen
    #   @pen
    # end
    # 
    # def pen=(pen)
    #   @pen = pen
    # end
    
    # the easy way in Ruby... (same results as above)
    attr_reader :list
    attr_accessor :pen
    
    def note item
      # when we tell the scribe to make a note, he/she adds it to the list
      @list << item
    end
    
    def write_everything
      # when we want to see all the items in the list
      @list.each{ |item| @pen.html_write item }
    end
  end
  
  # one of the most famous scribes in the O.T. was Ezra 
  # (and the only one I can think of right now), so ...
  ezra = Scribe.new pen
  # let's verify that Ezra has the pen object we've created
  p ezra.pen
  
  # time for Ezra to make some notes; first will be the time itself
  ezra.note "The time is #{Time.now}"
  # verify that the note is on the list
  p ezra.list
  
  # one more note for good measure
  ezra.note "Time to read the Law to the people"
  
  # now print it all out with the pen
  ezra.write_everything
  
  ## OUTPUT:
  # >> The time is 2013-03-20 08:37:03 -0400
  # >> Time to read the Law to the people
