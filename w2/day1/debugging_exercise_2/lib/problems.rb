# Run `bundle exec rspec` and satisy the specs.
# You should implement your methods in this file.
# Feel free to use the debugger when you get stuck.

require "byebug"

def prime?(num)
    return false if num < 2

    
    (2...num).each do |factor|
        if num % factor == 0
            return false
        end
    end

    true
end

def largest_prime_factor(num)
  prime_divisors = []

  (1..num).each do |i|
    if num % i == 0 && prime?(i)
      prime_divisors << i
    end
  end

  prime_divisors.last
end

### WALKTHROUGH SOLUTION ###

def largest_prime_factor(num)
  num.downto(2) do |factor|                     # There is a method for Integer's called Integer#downto which iterates down to the number given

    if num % factor == 0 && prime?(factor)
      return factor
    end
  end
end

def unique_chars?(string)
  chars_sorted = string.chars.sort

  (0...chars_sorted.length - 1).each do |idx|
    if chars_sorted[idx] == chars_sorted[idx + 1]
      return false
    end
  end

  true
end

### WALKTHROUGH SOLUTION ###

def unique_chars?(string)
  already_seen = []

  string.each_char do |char|
    if already_seen.include?(char)
      return false
    end
    already_seen << char
  end

  true
end

def dupe_indices(array)
  repeats_counter = {}
  alphabet = ("a".."z").to_a.each { |letter| repeats_counter[letter] = 0 }
  repeats_with_indices = Hash.new { |hash, key| hash[key] = Array.new(0) }
  
  array.sort.each.with_index do |char, idx|
    if char == array[idx + 1] || repeats_counter.key?(char)
      repeats_counter[char] += 1
    end
  end
  
  repeats_counter.select! { |key, val| val > 1 }

  array.each.with_index do |char, idx| 
    if repeats_counter.key?(char)
      repeats_with_indices[char] << idx 
      repeats_counter[char] -= 1
    end
    repeats_counter.select! { |key, val| val != 0 }
  end

  repeats_with_indices  
end

### WALKTHROUGH SOLUTION ###

def dupe_indices(array)
  indices = Hash.new { |hash, key| hash[key] = [] }

  array.each_with_index do |el, idx|
    indices[el] << idx
  end

  indices.select { |key, value| arr.length > 1 }
end

def ana_array(arr_1, arr_2)
  arr_1_word_counter = Hash.new { |hash, key| hash[key] = 0 }
  arr_2_word_counter = Hash.new { |hash, key| hash[key] = 0 }

  arr_1.each do |word|
    arr_1_word_counter[word] += 1
  end

  arr_2.each do |word|
    arr_2_word_counter[word] += 1
  end
  
  arr_1_word_counter == arr_2_word_counter 
end

### WALKTHROUGH SOLUTION ###

def ele_count(arr)
  count = Hash.new(0)

  arr.each { |ele| count[ele] += 1}

  count
end

def ana_array(arr_1, arr_2)
  count_1 = ele_count(arr_1)
  count_2 = ele_count(arr_2)
  count_1 == count_2
end