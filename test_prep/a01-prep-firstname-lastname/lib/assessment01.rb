require 'byebug'
class Array

  # Monkey patch the Array class and add a my_inject method. If my_inject receives
  # no argument, then use the first element of the array as the default accumulator.

  # def my_inject(accumulator = nil, &prc)
  #   accumulator ||= self.first
  #   self.each do |el| 
  #     yield 
  #   end
  #   accumulator
  # end
end

### SOLUTION ###

class Array
  def my_inject(accumulator = nil, &block)
    i = 0

    if accumulator.nil?
      accumulator = self.first
      i += 1
    end

    while i < length
      accumulator = block.call(accumulator, self[i])
      i += 1
    end

    accumulator
  end
end

# primes(num) returns an array of the first "num" primes.
# You may wish to use an is_prime? helper method.

def is_prime?(num)
  return true if num == 2
  (2..((num / 2) + 1)).none? { |possible_factor| num % possible_factor == 0 }
end

def primes(num)
  primes = []
  possible_prime = 2
  while primes.length < num
    if is_prime?(possible_prime)
      primes << possible_prime
    end
    possible_prime += 1
  end
  primes
end

# Write a recursive method that returns the first "num" factorial numbers.
# Note that the 1st factorial number is 0!, which equals 1. The 2nd factorial
# is 1!, the 3rd factorial is 2!, etc.

def factorials_rec(num)
  # debugger
  return [num] if num == 1
  factorials = []
  next_factorial = factorials_rec(num - 1)
  factorials += next_factorial
  (factorials.length..num).each do |index|
    factorials[index] *= factorials[index - 1]
  end
  factorials
end

### SOLUTION ###

def factorials_rec(num)
  if num == 1
    [1]
  else
    debugger
    facs = factorials_rec(num - 1)
    debugger
    facs << facs.last * (num - 1)
    facs
  end
end

class Array

  # Write an Array#dups method that will return a hash containing the indices of all
  # duplicate elements. The keys are the duplicate elements; the values are
  # arrays of their indices in ascending order, e.g.
  # [1, 3, 4, 3, 0, 3, 0].dups => { 3 => [1, 3, 5], 0 => [4, 6] }

  def dups
    hash = Hash.new { |hash, key| hash[key] = Array.new() }
    self.each.with_index do |el, idx|
      hash[el] << idx
    end
    hash.select { |_, val| val.length > 1 }
  end
end

### SOLUTION ###
# was nearly identical

class String

  # Write a String#symmetric_substrings method that returns an array of substrings
  # that are palindromes, e.g. "cool".symmetric_substrings => ["oo"]
  # Only include substrings of length > 1.

  def symmetric_substrings
    symmetric = []
    (0..self.length).each do |start|
      # you can start off at 2 here so that you don't get substrings 
      # shorter than len 2
      (2..(self.length - start)).each do |len|    
        substr = self[start,len]
        # then you can shovel into a symmetric array if it's a palindrome
        # while creating each substr
        symmetric << substr if substr == substr.reverse
      end
    end
    symmetric
  end
end

class Array

  # Write an Array#merge_sort method; it should not modify the original array.

  # def merge_sort(&prc)
  #   return self if self.length <= 1
  #   debugger
  #   middle = self.length / 2
  #   left = self.take(middle)
  #   right = self.drop(middle)
  #   Array.merge(left, right, &prc)
  # end

  # private
  # def self.merge(left, right, &prc)
  #   debugger
  #   until left.length == 1 || right.length == 1
  #     left.merge_sort(&prc)
  #     right.merge_sort(&prc)
  #   end
    
  #   left[0] < right[0] ? left + right : right + left
  # end
end

### SOLUTION ###

class Array
  def merge_sort(&prc)
    # See how I create a Proc if no block was given; this eliminates
    # having to later have two branches of logic, one for a block and
    # one for no block.
    prc ||= Proc.new { |x, y| x <=> y }

    return self if count <= 1
    debugger

    midpoint = count / 2
    sorted_left = self.take(midpoint).merge_sort(&prc)
    sorted_right = self.drop(midpoint).merge_sort(&prc)

    Array.merge(sorted_left, sorted_right, &prc)

  end

  private
  def self.merge(left, right, &prc)
    merged = []
    debugger
    
    until left.empty? || right.empty?
      case prc.call(left.first, right.first)
      when -1
        merged << left.shift
      when 0
        merged << left.shift
      when 1
        merged << right.shift
      end
    end

    merged.concat(left)
    merged.concat(right)

    merged
  end
end
