# OOP is a design pattern develoeprs use when building applications. 
# YOu've been using this design patterh through the last few sections, but
# now let's truly adopt an object oriented mindset.

# The goald of OOP is to create programs using objects that interact with e/o.
# We implmeent classes to create those objects. Let's take a look at 2 pillars
# of OOP: Abstraction and Encapsulation

### Abstraction ###

# In OOP, abstraction is the process of exposign essentail features of an object
# while hiding inner details that are not necessary to using the feature. Take this
# anaology: Many drivers do not understand the methacnical details of how a 
# steering wheel works, but they can still us ethe steering wheel to drive a car. 
# In a smiliar way, our classes should ahve methods that are simple to use because 
# they hid complex logic insdie of them. Let's explore examples.

# Below is a class that does not abstract how to enroll a student into a coruse:

class Course
  def initialize(name, teachers, max_students)
    @name = name
    @teachers = teachers
    @max_students = max_students
    @students = []
  end

  def max_students
    @max_students
  end

  def students
    @students
  end
end  

course = Course.new("Object Oriented Programming 101", ["Ada Lovelace", "Brian Kernighan"], 3)

# Let's to enroll a student
if course.students.length < course.max_students
  course.students << "Alice"
end

# Below is athe class with a nciely abstracted entroll method:

class Course
  def initialize(name, teachers, max_students)
    @name = name
    @teachers = teachers
    @max_students = max_students
    @students = []
  end

  def enroll(student)
    @students << student if @students.length < @max_students
  end
end  

course = Course.new("Object Oriented Programming 101", ["Ada Lovelace", "Brian Kernighan"], 3)

# Let's to enroll a student
course.enroll("Alice")

# Abstraction results in code that is readable and easy to use. There could be
# many steps that need to take place whena  student is enrolled, and a #enroll 
# method can take care of all of the behind teh scenes, unknown to the user stuff.

# We hvae been suing this concept of abstraction all the time! Array is a class and
# Array#include? is a method that we feel comforrtable using althoug we do not
# know the exact implmenetation details with the method. 

### Encapsulation ###

# simialar to abstractions, encapsulation closely relates methods and data 
# attributes together with the hope of preventing misuse. For us, the goal of 
# encapsulation is to give users access tot he thigns that are safe for them 
# to use. Some data we may choose to keep private or purposefully hide from outside
# users for the sake of security. One common way to encapsulate data attributes 
# is by making them only accessible through methods taht we explicitly design as
# programmers!

# Here's some food for thought: Ruby classes have some level of encapsulation by
# default. How so? Well, if we create a class with attributes, those attributes
# are inaccessible from teh outside unless define getter setter methods too!

# Design your code in a way that safeguards against misuse! Let's take a look 
# at an example. Say we wanted a class to track the order of people waiting in a 
# line. We call this concept a Queue. The rules of a Queue are simple: if you 
# are the first one in, then you are also the first one out. No cutting the 
# line! More programmatically, we remove from the front of the line, but we 
# add to the back of the line.

# we'll use the index o of an array to represent what is at the front of the line.

# Let's take a look at a properly encapsulate Queue class:

class Queue
  def initialize
    @line = []
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

grocery_checkout.add("bob")
grocery_checkout.add("alice")
grocery_checkout.remove          # => "bob"
grocery_checkout.add("noam")
grocery_checkout.add("donald")
grocery_checkout.remove          # => "alice"
grocery_checkout.remove          # => "noam"
grocery_checkout.remove          # => "donald"

# people who are added first to the line will leave first!

# You'll notice that above we decided to not include a getter for @line, that 
# is because we shouldn't include a full getter. If we give the user 
# full access to the @line then we can't enforce any of our rules and 
# the result is disastrous:

### Wrapping Up ###

# abstraction and encapsulation are just two pillars of OOP. AS you progress in 
# your craeer, you'll learn how to support other pills of OOP!