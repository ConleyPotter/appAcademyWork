### Motivation ###

# Before we learn about classes, let's get motivated! Why should we use classes
# and what advantages do they offer? 

### How to Create Cats Poorly ###

# As a programmer, you'll often want to model some object and the properites of
# that object. For example, a social media site may need to model a User with
# their username and a profile picture. Or perhaps a music site may need to 
# model a Song with it's title, genre, and duration. Folloiwn a/A tradition, 
# say we wanted to model some Cats in ruby! Our cats will have names, colors,
# and ages:

cat_1 = {name: "Sennacy", color: "brown", age: 3}
cat_2 = {name: "Whiskers", color: "white", age: 5}
cat_3 = {name: "Garfield", color: "orange", age: 7}

# Above we used hashes to represent our cats. this seems like a fair choice, 
# because we can use the key:value pairs of hahes to represent the properties of
# our cats. Now, imagine we wanted to create a thousand Cats. This leaves a lot
# of opportunity for typos. We want to follow the DRY rule and improve this
# code. By usign a class we can avoid this repetition easily and create objects
# of the same structure

class Cat
  def initialize(name, color, age)
    @name = name
    @color = color
    @age = age
  end
end

# A few things we'll want to note about the code above: 
## - To create a class we use the class keywoord
## - the name of a class must begin with a capital letter
## - we can define methods within a class

# You'll notice that we defined a method named initialize in our class. This is
# a special method name the at we will use when creating cats. The method
# expects 3 parameters, but what are @'s? @ is how we denote a instance variable
# or attribute of our class. That means that our cat's will have the attributes
# or properties of @name, @color, @age.

### Initializing New Cats ###

# Now that we have a cat class, we have a blueprint that can easily create cats
# for us. Let's put it to use:

class Cat
  def initialize(name, color, age)
    @name = name
    @color = color
    @age = age
  end
end

cat_1 = Cat.new("Sennacy", "brown", 3)
cat_2 = Cat.new("Whiskers", "white", 5)
p cat_1 #<Cat:0x007fb6d804cfe0 @age=3, @color="brown", @name="Sennacy">
p cat_2 #<Cat:0x007fb6d6bb60b8 @age=5, @color="white", @name="Whiskers">

# Let's recognize something a bit strange about this code: To create a Cat we must 
# call Cat.new, this must mean that new is a method on Cat. This is strange 
# because nowhere did we define a method literally named new. The trick is, when 
# we call Cat.new, ruby will be really calling upon the initialize method we 
# defined. A hint at this is the fact that the initialize method expects a name, 
# color, age and when we call Cat.new we pass in a name, color, age. You're 
# probably wondering why the heck we can't just call Cat.initialize; it seems way 
# more logical right??? The short answer to that is because reasons. This is 
# something we'll have to accept blindly for now: Cat.new will execute our 
# initialize method. As we explore more about classes we promise to explain the 
# weirdness behind new and initialize.

# With that out of the way, let's get to the punchline. When we call 
# Cat.new("Sennacy", "brown", 3), it will return an object to us that we store in 
# the variable cat_1. Notice that the object contains the attributes that result 
# from executing initialize. If we want to create more cats we simply call Cat.new 
# again, passing in any name, color, age we please. We can use our Cat class to 
# create any number of Cat instances. This means that cat_1 and cat_2 are 
# instances of Cat.

# Notice that when we print out an instance of a class, the notation will show 
# which class this instance belongs to and a unique id for this object: 
# <Cat:0x007fb6d804cfe0...

### Getter Methods ### 

# sicne we designed a cat instance to consist fo 4 attributes, it's common to 
# also want a way to refer to the vlaue of those attributes. To do this, we
# define "Getter Methods" to get (return) those attributes.

class Cat
  def initialize(name, color, age)
    @name = name
    @color = color
    @age = age
  end

  def get_name
    @name
  end
end

cat_1 = Cat.new("Sennacy", "brown", 3)
p cat_1.get_name # "Sennacy"

# Notice that we defined another method called get_name in our class. Cat is just
# the blueprint, so it does not refer to any single, particular cat. In 
# summary, we should call cat_1.get_name and not Cat.get_name.

# By convention, getter methods typically have the same name as the attribute
# they are returning. So instead: 

class Cat
  def initialize(name, color, age)
    @name = name
    @color = color
    @age = age
  end

  def name
    @name
  end

  def age
    @age
  end
end

cat_1 = Cat.new("Sennacy", "brown", 3)
p cat_1.name  # "Sennacy"
p cat_1.age   # 3

cat_2 = Cat.new("Whiskers", "white", 5)
p cat_2.name  # "Whiskers"
p cat_2.age   # 5

p cat_2.color # This will give NoMethodError: undefined method `color'

# Cool, so we can now refer to the  anme and age of any Cat instance! Note
# that if we don't create a getter for a particular attribute, we won't have
# a way to refer to that attribute. Such as in teh example above, we cannot
# refer to a Cat's color because we did not create the corresponding getter.

# A getter method cannot be used to modify the @attribute. You need setter methods
# to do that...

### Setter Methods ###

class Cat
  def initialize(name, color, age)
    @name = name
    @color = color
    @age = age
  end

  # getter
  def age
    @age
  end

  # setter
  def age=(number)
    @age = number
  end
end

cat_1 = Cat.new("Sennacy", "brown", 3)
p cat_1 #<Cat:0x007f8511a6f340 @age=3, @color="brown", @name="Sennacy">
cat_1.age = 42
p cat_1 #<Cat:0x007f8511a6f340 @age=42, @color="brown", @name="Sennacy">

# Now we have a working method that we can use to change the age! Great. But 
# something that feels uncomfortable here is how we call the method with 
# cat_1.age = 42. If age= is the method name, then what's up with the space 
# between age and =, as well as the lack of parentheses around our 42 arg? This
#  doesn't seem like a proper method call, but it truly is! The following two 
#  method calls are equivalent

cat_1.age=(42)
cat_1.age = 42

# For setter methods especially, we'll prefer the second version because the
# syntax is clearner. Ruby is a quite flexible language. In general you are
# not required to use parantheses around arguments when making a method call. 
# For example: "aeiou".include?("e") is equivalent to "aeiou".include? "e".
# As a matter of style and converion, we'll  only omit parantheses for method
# calls that don't take in args or are special exceptions like a classic
# setter method.

### Beyond Getters and Setters ###

# We can implement any arbitrary method we please in our class. 

class Cat
  def initialize(name, color, age)
    @name = name
    @color = color
    @age = age
  end

  def purr
    if @age > 5
      puts @name.upcase + " goes purrrrrr..."
    else
      puts "..."
    end
  end
end

cat_1 = Cat.new("Sennacy", "brown", 10)
cat_1.purr  # "SENNACY goes purrrrrr..."

cat_2 = Cat.new("Whiskers", "white", 3)
cat_2.purr  # "..."s
