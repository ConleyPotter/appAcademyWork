### Intro to Recursion ###

# Let's explore a bit of recursion as one of last topics! It will be covered in 
# further courses, but let's get our feet wet!

### What is Recursion? ###

# Let's write our first (broken) recursive method:

# recursive method definition: 
def say_hello
  p "hello"
  say_hello
end

say_hello # prints "hello" forever

# Notice taht the say_Hello method defintion contains a call to itself. A 
# recusive method defintions still obeys all the evalutation rules as a normal
# method, so like suual, the code will not run until we call it. 

# Let's steptrhough how this code evaluates. For cliarty, we'll be numbering the
# calls to say_hello. The initial call will be number 0:

  # - When we call say_hello for the first time (say_hello_0) we run the code
  #   inside the definition as usual. That means we print our "hello" and call
  #   say_hello again (say_hello_1) 
  # - say_hello_1 prints "hello" and calls say_hello_2, which calls say_hello_3, 
  #    and so on. 

# Our say_hello method enters an infinite loop where one call to the method 
# triggers another call. And that call triggers yet another. If you run this
# code, you will enter an inifinte loop. However, the program will crash with a
# SystemStackError: stack level too deep. Whever we call a method, some of our
# system's memory must be allocated to execute that method call. This is known
# as asdding to the stack. Since our say_hello code continuously calls methods
# forever, we will run out of space on the stack (run out of memory) and crash!

### Recursive Countdown ###

# In our previous example we saw how our recrusive method crashed because it 
# entered and inifinite recursive loop. Of course useful revursive methods should
# not crash. 

# let's build a recursive coundDown tha tstarts ticking down numbers:

def count_down(num)
  p num
  count_down(num - 1)

end

count_down(10) # this prints decreasing numbers starting at 10 forever

# This recursive defintion ealuates in a similar way to before, however, now we
# are passing in decreasing numbers. 

def count_down(num)
  if num == 0
    p "Houston, we have lift-off!"
    return
  end

  p num
  count_down(num - 1)
end

coutn_down(10) # prints 10 to 1, then "Houston, we have lift-off"

# Now our method stops when we hit 0!

## Anatomy of a Recursive Fucntion ###

# In recursive methods, we need to implement a way to stop the recursive loop 
# and prevent it from looping forever. We took care of the infinite loop issue
# in our countDown by using and if statement that prevents another recursive
# call. In general, we call such a statement the base case.

# A recursive method consists of two fundamental parts: 
  # - the base case where we halt the recursion by not making a further call
  # - the recursie step where we continue the recursion by making another
  #   subsequent call

def count_down(num)
  # the base case
  if num == 0
    p "we have lift-off"
    return;
  end

  p num
  # recursive step
  count_down(num - 1)
end

# Next let's solve some recursive problems!