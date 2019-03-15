require "byebug"

def avg(a, b)
  sum = a + b
  sum / 2.0
end

first_result = avg(15, 20)
second_result = first_result + 0.5

# p second_result

# byebug is required at the top of the file 

### display ###

# display will keep the variable and its current value at the top of every
# output when stepping through the code

def is_prime?(number)
  (2...number).each do |factor|
    return false if number % factor == 0
  end

  true
end

def first_n_primes(num_primes)
  primes = []
  num = 2

  debugger
  while primes.length < num_primes
    primes << num if is_prime?(num)
    num += 1
  end

  primes
end

first_n_primes(5) # => [2,3,5,7,11]