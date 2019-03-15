### fib ###

# Let's take a look a aclassic recursive problem, the fibonnaci sequence!

# Write a method fib(n) that takes in a number and returns the nth number of
# the fibonacci sequence.
# In the fibonacci sequence, the 1st number is 1 and the 2nd number is 1. To generate the
# next number in the sequence, we take the sum of the previous two fibonacci numbers.
# For example the first 5 numbers of the fibonacci sequence are `1, 1, 2, 3, 5`

# Examples:

# fib(1) # => 1
# fib(2) # => 1
# fib(3) # => 2
# fib(4) # => 3
# fib(5) # => 5
# fib(6) # => 8
# fib(7) # => 13

# To get a fibonacci number, we need to take the sum of the previous two. Take
# a look at th efollowing ways we can describe fib. 

# fib(5) = fib(4) + fib(3)
# fib(4) = fib(3) + fib(2)
# fib(3) = fib(2) + fib(1)
# fib(2) = 1 base case
# fib(1) = 1 base case

# In general

fib(n) = fib(n - 1) + fib(n - 2)

# Finally, in code:

def fib(n) 
  return 1 if n === 1 || n === 2
  fib(n - 1) + fib(n - 2)
end

# To make a sense of recursive code like fib, use abstraction and your comfort
# with helper methods. Recursion is only "different" from using regular helper
# methods bc we are usign the same method as the helper. However, you can use 
# abstraction in the same way. If we wanted to solve fib(5) we can decompose 
# it into fib(4) + fib(3)! beautiful.

### When is recursion approrpriate? ###

# Recursion allows us to solve problems in an elegant way. However, recursion 
# is a tool that is only appropriate for certain problems. Recusion is used to
# solve problemst aht can be decompsed into smaller versions of the
# problem. For example we can decompose fib(n) into fib(n - 1) + fib(n - 2). 
# Intuitively, we know fib(n - 1) is a smaller problem than fib(n). The
# easiest subproblem is fib(1) or fib(2), becuase the answer is 1; this is an
# assumption in the fibonnaci sequence. We use the easiest suproblems as the base
# case in recursion. 

