### All of the following have been coded using mutliple TDD iterations ###

def average(num_1, num_2)
  (num_1.to_f + num_2.to_f) / 2           # Used floats here so that it does "real division"
end

### WALKTHROUGH SOLUTION ###

def average(num_1, num_2)
  (num_1 + num_2) / 2.0
end

def average_array(array)
  array.sum.to_f / array.length           # same case here
end

### WALKTHROUGH SOLUTION ###
def average_array(array)
  array.sum / (arra.length * 1.0)
end

def repeat(string, number)
  string * number                         # no biggie here
end

### WALKTHROUGH SOLUTION ###
def repeat(string, num)
  new_string = ""
  num.times { new_string += string }
  new_string
end

def yell(string)
  string.upcase + "!"                     # or here
end

def alternating_case(string)
  words = string.split(" ")               # split the string into an array of words
  words.map!.with_index { |word, index|   # map in place, with an index counter, each word
    if index % 2 == 0
      word.upcase                         # to either uppercase...
    else 
      word.downcase                       # or lowercase depending on it's position in the array
    end
  }
  words.join(" ")                         # put the words back into a string
end

### WALKTHROUGH SOLUTION ###
def alternating_case(string)
  words = string.split(" ")
  new_words = words.map.with_index do |word, i|
    if i % 2 == 0
      word.upcase
    else
      word.downcase
    end
  end
  new_words.join(" ")
end

