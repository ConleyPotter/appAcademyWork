##### SCOPE NOTES #####

### Scope ###

# You've been unwittingly utilizing the concept of scope in your code. Let's 
# take a moment to explore the fundamentals of scope and define some rules!
# Scope describes the location in your program where a variable is accessible. 

### Methods and Local Scope ###

# Let's explore lexical scope. Lexical scope describes hos a variable name 
# evaluates in nested code. In other words, how variable names resolve if we
# put them in structures like methods, coniditonals, or blocks?

# To start, let's say we had some duh-duh obvious code:

def say_hello
  message = "hello"
  p message
end

say_hello

# Above we can say that say_hello method has it's own scope where the variable 
# message is defined. This means we are free to reference and print that 
# variable in that same scope. The say_hello method is a local scope. 
# This will be true for any moethod. 


# This means that if we are outside fo the say_hello method/scope, we cannot
# reference the message variable: 

def say_hello
  message = "hello"
end

say_hello
p message # NameError: undefined local variable

# the code above will fail with an error because we are referencing a variable, 
# message, but it will not be definied that scope. WE can imagine there being
# two scopes int aht example. There is the say_hello method scope and the 
# surrounding scope that is on teh outside of say_hello

# Let's try the opposite scenario. What if we had defined a variable in the 
# surrounding scope and tried to reference it within the say_hello scope:

message = "hi"

def say_hello
  p message     # NameErorr: undefined local variable
end

say_hello

# Above we suffer teh same issue. The say_hello scope does not have acces to the
# surrounding scope. From oru previous exmpale it semees that as socpe is determiend
# by a method. E/ method will have it's own local scope. This is going to be our
# rule of thumb. Technically we consider code out in teh open as another local 
# scope, although it's not a method. It's common for new ruby programmers to 
# think taht variables defined out in teh open will automatically be accessible
# in the global scope, but this is not true. 

### Global Variables ###

# Are there other areas of scope? Everywhere area in our code can access the 
# global scope. To dfines variables in the global scope, we must use spcial 
# syntax. Let's redo our last example utilizing global scope: 

$message = "hello globe"

def say_hello
  p $message
end

say_hello # => "hello globe"

# This code will correctly print "hello globe". Creating a global variable is 
# simple, put a $ at the beginningof the name. Here's a smiliar example, this
# time creating the global $message inside of say_hello but referencing it from
# the outwside: 

def say_hello
  $message = "hello globe"
end

say_hello
p $message # => "hello globe"

# Ruby automatically defines some global variables for us to reference. For
# example, $PROGRAM_NAME will be a string describing the name of our program. 
# Later in the course we'll use other lgobal names like $stdin and $stdout
# that handle user input and output. For now, just understand that we can 
# reference a $variable_name anywhere in our program because it is global!

### Constants ###

# Let's take a quick detour to explore an additional way to create a variable, 
# using a constant. A constant is denoted syntatically by beginning the name
# with a capital letter. By convention we like to make the entire name capital
# to emphasize it being a special constant. 

# a constant variable cannot be reassigned. 

FOOD = "pho"
p FOOD # => "pho"

FOOD = "ramen"  # warning; already initizlied constant FOOD
                # warning: previous definition of FOOD was here


# You'll receive a warning message when reassigning a constant. Reassignment 
# means using = on that name again. A common point of confusion is that while
# you cannot reassign a constant, you can still mutate that constant name
# without warning

FOOD = "pho"
FOOD[0] = "P"
p FOOD # => "Pho"

# Note that above we did not reassign to the FOOD name, instead we assigned
# to an index of the FOOD string. The key takeaway is that onstants can still 
# mutate or be "changed", they jsut can't be reassigned. 

# Why bring up constants in our chatter about scope? Because constants will 
# exist in global scope! We can do VARIABLE or $variable to ensure global scoping

FOOD = "pho" 
$drink = "iced coffee"

def my_favorite
  p FOOD
  p $drink
end

my_favorite

# The code above works because both variables are accessible in global scope. 
# This means they can be referenced anywehred in our code! However, we should
# use global scope sparingly. We want to minimize our methods all referencing
# data that is outside of them, as manipulations to the data will be hard to 
# track. Instead we should write methods that accept data as arguments as
# it is more explicit where the data is coming from. 

### What does not have it's own scope? ###

# So methods and the global scope will be our prmiary structures that provide
# scope. Now let's highlight what structures don't have their own scope. 

# Blocks don't have their own scope, they are really a apart of the conatining
# method's scope. Below, the times block can reference message. 

def say_bye
  message = "bye"

  3.times do 
    p message
  end
end

say_bye

# Other structures like conditoinals or while loops also don't have their own 
# scope, they are really part of the containing scope. Although a variable is
# defined within the if statement below, it is still accessible outside
# of the if statement, because if's dont' have their own scope. 

if true
  drink = "cortado"
end

p drink # No error