# Write a method, coprime?(num_1, num_2), that accepts two numbers as args.
# The method should return true if the only common divisor between the two numbers is 1.
# The method should return false otherwise. For example coprime?(25, 12) is true because
# 1 is the only number that divides both 25 and 12.


### What I wrote originally ###
def getDivisors(num) 
  counter = num
  divisors = []

  while counter > 1
    divisors << counter if num % counter == 0
    counter -= 1
  end

  divisors
end

def coprime?(num_1, num_2) 
  num_1_divisors = getDivisors(num_1)
  num_2_divisors = getDivisors(num_2)

  both_divisors = num_1_divisors.concat(num_2_divisors)

  both_divisors.sort!
  
  if both_divisors.uniq.length == both_divisors.length
    true
  else
    false
  end

end

### Answer in the walkthrough ###

def coprime?(num_1, num_2) 
  (2..num_1).none? { |divisor| num_1 % divisor == 0 && num_2 % divisor == 0 }
end

p coprime?(25, 12)    # => true
p coprime?(7, 11)     # => true
p coprime?(30, 9)     # => false
p coprime?(6, 24)     # => false
