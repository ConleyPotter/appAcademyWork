def is_prime?(number)
  divisors = []

  (1...number).each do |i|
    if number % i == 0
      divisors << number
      return false if divisors.length > 2
    end
  end

  return divisors.length == 1
end

def nth_prime(number)
  primes = []
  nth = 1
  possible_prime = 2
  prime = false

  while nth <= number
    while !prime
      if is_prime?(possible_prime)
        primes << possible_prime
        prime = true
      end
      possible_prime += 1
    end
    prime = false
    nth += 1
  end

  primes.last
end

def prime_range(min, max)
  if min < max
    return (min..max).select { |num| num if is_prime?(num) }
  else
    return (max..min).select { |num| num if is_prime?(num) }
  end
end
