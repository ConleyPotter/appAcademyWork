### factorial ### 

# Recall our factorial rpoblem from earlier in the course:
# Write a method `factorial(n)` which takes a number and returns the factorial of n.
# A factorial is the product of all whole numbers between 1 and n, inclusive.
# For example, `factorial(5)` is 5 * 4 * 3 * 2 * 1 = 120.

# How can we solve this problem using recursion? Notice taht the structure of
# factorial has us take decreasing numbers similar to countDown. However, this
# time we need to keep multiplying them together. 

# If we lay out the math, we'll notice a pattern

# factorial(5) = 5 * 4 * 3 * 2 * 1
# factorial(4) = 4 * 3 * 2 * 1
# factorial(3) = 3 * 2 * 1
# factorial(2) = 2 * 1
# factorial(1) = 1 (base case)

# In the outline above, notice that as the input number becomes smaller and smaller,
# the problem we solve also becomes smaller. 

# let's see the pattern programmatically: 

# factorial(5) = 5 * factorial(4)
# factorial(4) = 4 * factorial(3)
# factorial(3) = 3 * factorial(2)
# factorial(2) = 2 * factorial(1)
# factorial(1) = 1 (base case)

# Or in general, if n is some number: 
  # - factorial(n) = n * factorial(n-1)
  # - factorial(1) = 1

# now let's implement factorial with some recursive Ruby: 
def factorial(n)
  return 1 if n == 1
  n * factorial(n - 1);
end

factorial(5) # => 120

# Note that mathematically, facotrial(0) = 1 so we could have also used that base case.

### Solving a problem recursively ###

# because every recursive problem must have a base and recursive case, we can 
# follow these steps to help us write a recursive method: 

# 1. Identify the base case int eh problem and code it. The base case should
#    explicitly handle the scenario(s) where the arguments are so trivially  "small",
#    that we immediately know the result without further consideration. Be sure
#    it works by testing it. 
# 2. Solve th enext level fo the problem, using the result of the base case. Test.
# 3. Modify the code in step 2, generalizing it for everl level of the problem.