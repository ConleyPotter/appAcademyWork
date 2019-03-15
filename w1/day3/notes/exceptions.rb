##### Exceptions in Ruby #####

# Exceptions are what Ruby uses to deail with errors or othe runexpected events.
# For now it's okay to use exception and error synonymously. If you have made
# it this far in teh course, chances are you have run into many exceptions.
# Here we are referring to exceptions in the cdoe that will literally crash
# your program and stop execution immediately. 

# Here are two examples of classic exceptions or errors that will halt our 
# execution 

def my_method(arg_1, arg_2)
  puts arg_1
  puts arg_2
end

my_method("a") # ArgumentError: wrong number of arguments (given 1, excepted 2)

5 + nil # TypeError: nil can't be coerced into Integer

# Upon reaching an exception, the default behavior in ruby is to terminate the
# program. However, we can also define our own behavior ot handle exceptions.

### Handling Exceptions ###

# Let's explore how we can implement our own custom exception handling in Ruby. 
# Exception handling can be very involved, but let's just focus on the
# fundamentals. Let's say we had some isolated code that is vulnerable to an
# exception: 

10 / num

# Do you see a potential problem in teh code above? That cdoe seems innocous, 
# right? ...Wrong! What if num is 0: 

num = 0
10 / num # ZeroDivisionError: dvided by 0

puts "finished"

# Reaching the ZeroDivisionErorr exception would halt execution of the program
# and we would never get to reach the final puts "finished". This could be 
# deadly if there is some ciritical code after the exception that we sitll want
# to exceute, regardless of the fact we got an exception. 

# With that in mind, let's redesign this code to handle division by zero more
# gracefully. We'll need to use a new structure that is specific to handling
# excpetions, begin...rescue.

num = 0
begin
  puts "dividing 10 by #{num}"
  ans = 10 / num
  puts "the answer is #{ans}"
rescue
  puts "There was an error with that division."
end

puts "--------"
puts "finished"

# The output of the above code si: 

dividing 10 by 0
There was an error with that division. 
--------
finished

# The behavior of begin...rescue is this: The code in teh begin block will
# execute until an exception is reached. Oncean exception is reached, the 
# execution will immediately jump to rescue. This behavior is evident by the 
# fact that the cdoe above doesn't print "the answer is ", because the exception
# is reached on the line before. 

# In the event that an exception is never hit in the begin block, then exceution
# willnever go to rescue. This is the case in the following code: 

num = 5

begin
  puts "dividing 10 by #{num}"
  ans = 10 / num
  puts "the answer is #{ans}"
rescue
  puts "there was an error with that division"
end

puts "-------"
puts "finished"

# The output f the above code is 

dividing 10 by 5
the answer is 2
--------
finished

# Cool! Now we know the basics of exception handling in ruby. begin running
# some code, and if something goes horribly wrong, we jump to rescue it. 
# begin...rescue has a somewaht similar control flow to an if...else in taht
# both structures ahve branching logic. We explore how to handle 
# ZeroDivisionError, but other errors can be rescued too. Here are a few more
# common error tyeps that are native to ruby: 

# ArugmentError
# NameError
# NoMethodError
# IndexError
# TypeError

# This is by no means an exhaustive list, but these are the common ones.


### Raising Exceptions ### 

# Previously we explored how to handle native exceptions like ZeroDivisionError
# but what if we wanted to implement our own exceptions? The point of an 
# exception is to flag an exceptional scenario in teh cdoe that should be 
# handled in a specific way. As a programmer, you can decide what those
# exceptional scenarios are!

# Say we wrote this method: 

def format_name(first, last)
  first.captialize + " " + last.captialize
end

format_name("grace", "HOPPER") # => "Grace Hopper"

# It's obvious how this method should be used. That is, we ought to pass in two
# string when calling format_name. But this is still prone to the misuse:

format_name(42, true) # => NoMethodEror: undefined method

# This code will reach a native exception, but it could be better. We want
# the exception message to really describe how our format_name method was 
# misused. Right now the error message really pertains to misuse of capitalize.
# The current exception message is also uncomfortable because it exposes the 
# inner implementation details of our format_name method. For someone that is
# calling our method, maybe we don't want them to know what operation we do 
# inside. If they have intellignece of the inner workings of our method, they
# could use that knowledge to deduce how to break our cdoe. We know format_name
# is a harmless method, but  if it was an absolutely critical method, we would
# want to protect it. 

# We'll let you be the judge, which exception do you think is more appropriate:

format_name(42, true) # => NoMethodError: undefined method `capitalize' for 42:Integer
# OR
format_name(42, true) # => RuntimeError: arguments must be strings

# Let's implement the second exception! Since we want to raise an exception when
# the arugments are not strings, we'll need a quick aside on how to check data
# types:

"hello".instance_of?(String) # => true
42.instance_of?(String)      # => false

# Simple enough! Let's use this to rewrite format_name:

def format_name(first, last)
  if !(first.instance_of?(String) && last.instance_of?(String))
    raise "arguments must be strings"
  end

  first.capitalize + " " + last.capitalize

format_name("grace", "hopper") # => "Grace Hopper"
format_name(42, true)          # => RuntimeError: arguments must be stringsformat_name("grace", "hopper'")

# In the code above we see raise, this is how we can make exceptions manually
# You'll commonly hear the phrase, "raise an error" or "raise an exception"
# to refer to this.

### Bring it all together ###

# Since oru format_name method can raise an exception, we can also handle it
# with begin...rescue. 

def format_name(first, last) 
  if !(first.instance_of?(String) && last.instance_of?(String))
    raise "araguments must be strings"
  end

  first.capitalize + " " + last.capitalize
end

first_name = 42
last_name = true
begin
  puts format_name(first_name, last_name)
rescue
  # do stuff to rescue the "arugmetns must be strings" exception
  puts "there was an exception :("
end

# An important distinction to note is that raise is how we bring up an exception,
# whereas begin...rescue is how we react to that exception. 

# There is much more to exceptions in ruby, but these are the fundamentals that
# you'll need for alpha course. In the course, you'll run into scenarios where
# a spec may say "should raise an error when...". Solving these specs can be
# as simple as using raise with an if statment, just like we explore in our
# format_name method!