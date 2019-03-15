### All of these methods were constructed iteratively using the TDD approach ###

def partition(array, number)
  toReturn = Array.new(2) {Array.new()}                   # initialize an empty 2d array
  array.each do |element|                                 # iterate through every element of the parameter array
    if element < number
      toReturn[0] << element                              # put it in the left-hand array if it's less than the parameter number
    else
      toReturn[1] << element                              # otherwise put it in the right-hand array
    end
  end

  toReturn
end

### WALKTHROUGH SOLUTION ####

def partition(array, number) 
  less = []
  greater = []

  array.each do |el|
    if el < number
      less << el
    else 
      greater << el
    end
  end

  [less, greater]
end

def merge(hash_1, hash_2)
  toReturn = Hash.new()                                   # initialize an empty hash, which will be populated

  hash_1.each_key do |key|                                # iterate through every key in hash_1
    if hash_2.key?(key)                                   # skip the key if it's in the second hash
      next
    else
      toReturn[key] = hash_1[key]                         # otherwise add it to the hash initialized above
    end
  end
  hash_2.each_key do |key|
    toReturn[key] = hash_2[key]                           # no need to worry about collision with hash_1 now
  end

  toReturn
end

### WALKTHROUGH SOLUTION ####

def merge(hash_1, hash_2) 
  new_hash = {}
  hash_1.each { |key, value| new_hash[key] = value}
  hash_2.each { |key, value| new_hash[key] = value}
  new_hash
end

def censor(sentence, array)
  $vowels = "aeiou"                                       # store the vowels for further comparison
  new_sentence = ""                                       # this is what we'll return at the end
  words = sentence.split(" ")                             # split the sentence in to an array of wrods
  
  words.each.with_index do |word, index|                  # iterate through every word, with an index counter
    if array.include?(word.downcase)                      # if the word is in the parameter array
      word.each_char do |char|                            # then iterate through its characters
        if $vowels.include?(char.downcase)                # if you find a vowel
          new_sentence += "*"                             # add a star to the new sentnece
        else
          new_sentence += char                            # otherwise just add the character
        end
      end
    else
      new_sentence += word                                # add the whole word if it's not in the parameter array
    end

    new_sentence += " " if (index != words.length - 1)    # don't add a space at the end, but otherwise add a space
  end

  new_sentence
end

### WALKTHROUGH SOLUTION ####

def censor(sentence, array)
  words = sentence.split(" ")

  new_words = words.map do |word|
    if array.include?(word.downcase)
      star_vowels(word)
    else
      word
    end
  end

  new_words.join(" ")
end

def star_vowels(string)
  vowels = "aeiou"
  new_str = ""

  string.each_char do |char|
    if vowels.include?(char.downcase)
      new_str += "*"
    else
      new_str += char
    end
  end

  new_str
end

### END OF CENSOR METHOD ###

def power_of_two?(number)
  return true if number == 1                              # 1 is definitely a power of two
  return false if number % 2 == 1                         # any odd number definitely isn't
  # keep dividing by 2 until you reach a number between 0 and 2
  while !((0..2).include?(number))
    number /= 2
  end

  if number == 2                                           # if 2 got returned from the loop above, the paramter number is a power of two
    return true
  end
  
  false
end

### WALKTHROUGH SOLUTION ####

def power_of_two?(number)
  product = 1
  while product < number
    product *= 2
  end

  product == number
end