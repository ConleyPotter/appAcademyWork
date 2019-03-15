# Write a method, coprime?(num_1, num_2), that accepts two numbers as args.
# The method should return true if the only common divisor between the two numbers is 1.
# The method should return false otherwise. For example coprime?(25, 12) is true because
# 1 is the only number that divides both 25 and 12.

def coprime?(num_1, num_2)
  num_1_divisors = [*(2..num_1)].select! { |x| num_1 % x == 0}
  num_2_divisors = [*(2..num_2)].select! { |x| num_2 % x == 0}

  both_divisors = num_1_divisors.concat(num_2_divisors)

  both_divisors.uniq.length == both_divisors.length
end

### Answer in the walkthrough ###

def coprime?(num_1, num_2) 
  (2..num_1).none? { |divisor| num_1 % divisor == 0 && num_2 % divisor == 0 }
end

p coprime?(25, 12)    # => true
p coprime?(7, 11)     # => true
p coprime?(30, 9)     # => false
p coprime?(6, 24)     # => false
