require "byebug"

# Write a recursive function that returns the prime factorization of
# a given number. Assume num > 1
#
# prime_factorization(12) => [2,2,3]
def prime_factorization(num)
    
end

def is_prime?(num)
    return true if num <= 2
    (0..(num - 1) / 2).none? { |i| num % i == 0 }
end

# Write a method that returns b^n recursively. 
# Your solution should accept negative values for n.

def exponent(b, n)
    return 1 if n <= 0
    return b if n == 1

end

# Write a method that returns the sum of all elements in an array recursively

def rec_sum(nums)
    # return 0 if nums.nil?
    # return nums.first if nums.size == 1
    # debugger
    # sum = 0
    # debugger
    # sum += nums.first + rec_sum(nums[1..-1])
end
# Write a method, `digital_root(num)`. It should Sum the digits of a positive
# integer. If it is greater than 10, sum the digits of the resulting number.
# Keep repeating until there is only one digit in the result, called the
# "digital root". **Do not use string conversion within your method.**
#
# You may wish to use a helper function, `digital_root_step(num)` which performs
# one step of the process.

def digital_root(num)
    return num if num < 10
    digital_root(num / 10) & 10
end

# Write a method that returns the sum of the first 
# n even numbers recursively. Assume n > 0.

def first_even_numbers_sum(n)
    return 2 if n <= 1
    first_even_numbers_sum(n - 1) + (n * 2)
end

# n:      1    2   3   4   5
# nth:    2    4   6   8   10
# f(n)    2    6   12  20  30

def first_even_numbers(n)
    return [2] if n <= 1
    even_num = first_even_numbers(n - 1)
    even_nums = []
    even_nums += even_num
    even_nums << (even_nums.last + 2)
end
# Write a method that finds the sum of the first n
# fibonacci numbers recursively. Assume n > 0.

def fibs_sum(n)
end
# Write a recursive method that takes in a string to search and a key string.
# Return true if the string contains all of the characters in the key
# in the same order that they appear in the key.
#
# string_include_key?("cadbpc", "abc") => true
# string_include_key("cba", "abc") => false
def string_include_key?(string, key)
    # working except edge cases
    return false if string.empty?
    key.each_char do |char|
        return false if !string.include?(char)
        start = string.index(char)
        string_include_key?(string[start, -1], key)
    end
    true
end

# Using recursion and the is_a? method,
# write an Array#deep_dup method that will perform a "deep" duplication of the interior arrays.

def deep_dup(arr)
    return arr if !arr.is_a?(Array)
    duped = []
    arr.each do |el| 
        if el.is_a?(Array) 
            duped << deep_dup(el)
        else
            duped << el
        end
    end
    duped
end

# Write a recursive method that returns the first "num" factorial numbers.
# Note that the 1st factorial number is 0!, which equals 1. The 2nd factorial
# is 1!, the 3rd factorial is 2!, etc.

def factorials_rec(num)
    return 1 if num == 1
    factorials = []
    factorials += (factorials_rec(num - 1) + factorials_rec(num) + 1)
    factorials
end

