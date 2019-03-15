# THhe previous attr methods are a godo example of this. The borad name for
# code or syntax that is a "shortcut" for othe rcode is "Syntatic Sugar". 
# IE, attr_reader is syntactic sugar for defining a full getter method! We use
# syntactic sugar to sweeten up our cdoe, making it more readable. 

### Implementing "operator" Methods ###

# Like we alluded to in previou sections of the course. You can implement +, 
# ==, >, etc. methods in your classes. Let's say we had a Person class and we
# wanted to implement equality, == ,on the basis of last_name: 

class Person
  attr_reader :first_name, :last_name

  def initialize(first_name, last_name, age)
    @first_name = first_name
    @last_name = last_name
    @age = age
  end

  def ==(other_person)
    self.last_name == other_person.last_name
  end
end

person_1 = Person.new("Jane", "Doe", 20)
person_2 = Person.new("John", "Doe", 18)
person_3 = Person.new("John", "Wayne", 18)

# Calling Person#== without any syntactic sugar is awkward:
p person_1.==(person_2)     # true

# With syntactic sugar, it's much more elegant:
p person_1 == person_2      # true
p person_2 == person_3      # false

# as always, if you treat Person#== as a method where "==" is the name, then we
# can call it with person_1.==(person_2). In this context since person_1 is the
# obect calling ==, self will refer ot person_1 inside of the method. person_2 is
# other_person argument since it is being passed. Syntactic sugar comes in when we drop
# the . and (). The resulting calls are much cleaner

# FOr these methods like ==, +, >, etc. you can typically identify the object to the 
# left as what self will refer to within teh method. The arugment will be the 
# objet to the right. This si exactly the case in our Person#== method.

### Implementing # ###

# Let's explore how to implement a custom #[] method on our classes. 
# We often use this method to index an Array or key a Hash.

# Say we wanted to have a Queue#[] method to return the element at the given 
# position in the @line. Like we explored in our abstraction and encapsulation 
# lesson, we want to avoid giving direct access to the @line array.

class Queue
  def initialize
    @line = []
  end

  def [](position)
    @line[position]
  end

  def add(ele)
    @line << ele # add ele to back of line
    nil
  end

  def remove
    @line.shift  # remove front ele of line
  end
end

grocery_checkout = Queue.new
grocery_checkout.add("Alan")
grocery_checkout.add("Alonzo")

# Calling Queue#[] without any syntactic sugar is ugly:
grocery_checkout.[](0)          # "Alan"
grocery_checkout.[](1)          # "Alonzo"

# With syntactic sugar, it's waaaaay better:
grocery_checkout[0]             # "Alan"
grocery_checkout[1]             # "Alonzo"

# Notice that the syntatctic sugar when calling the #[] method is more involved
# than teh previous example. gorcery_hceckout.[](1) is equivalent to 
# grocery_checkout[1]. Using the syntactic sugar, we can put a number between
# the square brackets and it will be interpreted as the first arg to the #[] 
# method.

### Implementing #[]= ###

# Building off of the #[] method what if I wanted the ability to assign
# to a specified position by implementing a  #[]= method? Let's take a look how
# we can define this special setter:

class Queue
  def initialize
    @line = []
  end

  def [](position)
    @line[position]
  end

  def []=(position, el)
    @line[position] = el
  end

  def add(el)
    @line << el # add el to the back of the line
    nil
  end

  def remove
    @line.shift #remove front el of the line
  end
end

grocery_checkout = Queue.new
grocery_checkout.add("Alan")
grocery_checkout.add("Alonzo")

# Let's call Queue#[]= without syntactic sugar:
grocery_checkout.[]=(0, "Grace")
p grocery_checkout    #<Queue:0x007fe7a7a29ec8 @line=["Grace", "Alonzo"]>

# Let's call Queue#[]= again, but with syntactic sugar:
grocery_checkout[1] = "Grace"
p grocery_checkout    #<Queue:0x007fe7a7a29ec8 @line=["Grace", "Grace"]>

# From the above we see that grocery_hceckout.[]=(0, "Grace") is equivalent to
# grocery_checkout[0] = "grace". Looking at how we defined the []= method, we
# can gather that when we use the syntactic sugar for calling []=, the data
# that we put between teh brackets will be the frist argument, and what comes 
# after the equal sign will be the second argument to our method. 


