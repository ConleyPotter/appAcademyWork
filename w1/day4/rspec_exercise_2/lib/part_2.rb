def palindrome?(string)
  # chars splits the string into an array of chars, and then I go through each
  # of them and map each to the character at the position opposite it
  reversed = string.chars.map.with_index { |char, idx|
    string[(string.length - idx - 1)]
  }.join

  # if what we constructed above, the reversed string, is equal to the original
  # it is a palindrome
  return true if string == reversed

  false
end

### WALKTHROUGH SOLUTION ###

def palindrome?(string)
  string.each_char.with_index do |char, i|
    # strings in Ruby have negative indexing
    if string[i] != string[-i - 1]
      return false
    end
  end

  true
end 

def substrings(string)
  # create a new array, which will be what holds all of the possible substrings
  # of the parameter "string"
  substrings = Array.new(0)

  # look through each character in the string, keeping track of its index
  string.each_char.with_index do |char, idx|
    # then loop through and add each substring to the above array by 
    # slicing the string at the designated spots. Always start slicing from the
    # current position in the above loop, then iteratively go through
    # and stop at each index ahead of the position we're at.
    for charPosition in (idx..string.length)
      substring = string[idx..charPosition]
      # only add the substring to the array if it is unique
      substrings << substring if !substrings.include?(substring) 
    end
  end

  substrings
end

### WALKTHROUGH SOLUTION ###

def substrings(string)
  subs = []

  (0...string.length).each do |start_idx|
    (idx...string.length).each do |end_idx|
      subs << string[start_idx..end_idx]
    end
  end

  subs
end

def palindrome_substrings(string)
  # initialize a new array to hold all the substrings of the parameter string
  # that are palindromes and make an array of all the substrings of the
  # parameter string, method described in substrings(string) above
  palindrome_substrings = Array.new(0)
  substrings = substrings(string)

  # loop through every substring, collected above
  for i in (0..substrings.length - 1)
    # it can't be a palindrome if it is less than 3 characters in length
    if substrings[i].length < 3
      next
    # if it can be a palindrome, check that is using the method described above
    else
      palindrome_substrings << substrings[i] if palindrome?(substrings[i])
    end
  end
  
  palindrome_substrings
end

### WALKTHROUGH SOLUTION ###

def palindrome_substrings(string)
  substrings(string).select { |substr| substr.length > 1 && palindrome?(substr) }
end

