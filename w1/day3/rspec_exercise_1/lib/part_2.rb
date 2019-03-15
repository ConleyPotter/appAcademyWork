### All of the following have been coded using mutliple TDD iterations ###

def hipsterfy(word)
  vowels = "aeiou"                                # group the vowels together for further comparison
  for i in (0..word.reverse!.length)              # reverse the string and loop through it
    if vowels.chars.include?(word[i])             # if a vowel is found in the word
      word[i] = ""                                # set it to a blank string
      break                                       # and break out, so as to only strip the first vowel
    end
  end

  word.reverse                                    # return the string back in place
end

### WALKTHROUGH SOLUTION ###

def hipsterfy(word)
  vowels = "aeiou"
  while i >= 0
    if vowels.include?(word[i])                   # String has an include? method
      return word[0...i] + word[i+1..-1]          # String slicing and concatenation
    end

    i -= 1
  end

  word
end

### END HIPSTERFY ###

def vowel_counts(string)
  vowels = "aeiou"                                # Group the vowels same as above
  vowelHash = Hash.new()                          # and create a hash that will 
                                                  # store the final count of vowels in a string
  for i in (0..string.length - 1)                 # loop through the entire string
    if vowels.chars.include?(string[i].downcase)  # and if the character is in the vowel set
      if vowelHash[string[i].downcase] == nil     # and it is not already in the hash
        vowelHash[string[i].downcase] = 1         # set its count to 1
      else                                        # if it is already in the hash
        vowelHash[string[i].downcase] += 1        # increment its counter
      end
    end
  end

  vowelHash
end

### WALKTHROUGH SOLUTION ###

def vowel_counts(string)
  counts = Hash.new()
  vowels = "aeiou"

  string.each_char do |char|
    if vowels.include?(char.downcase)
      counts[char.downcase] += 1                  # No need to check for nil
    end
  end

  counts
end

### END VOWEL_COUNTS ###

def caesar_cipher(message, n)
  # Here we're making a hash, indexing every letter in the alphabet
  alpha_hash = Hash.new()                               
  "abcdefghijklmnopqrstuvwxyz".each_char.with_index { |char, idx| alpha_hash[char] = idx }

  # We'll loop through and change every character, except symbols, with map
  message.chars.map { |char|
    # record the original index position of the letter for further mutation
    originalAlphaPosition = alpha_hash[char.downcase]
    # and make sure it's not a symbol using it's ASCII code
    if (char.sum >= 65 && char.sum <= 90) || (char.sum >= 97 && char.sum <= 122)
      # Grab the index from the hash created above and then set
      # the char at the current map index to the char at the alphabet hash's
      # index + n. Modulo by 26 in order to loop back around the alphabet
      char = alpha_hash.key((originalAlphaPosition + n) % 26)
    else
      # This else is for the symbol case
      char = char
    end
  }.join # because we split the message into an array of its characters, join
end

### WALKTHROUGH SOLUTION ###

caesar_cipher(message, n) 
  alphabet = ("a".."z").to_a
  new_message = ""

  message.each_char do |char|
    if alphabet.include?(char)
      old_index = alphabet.index(char)
      new_index = old_index + n
      new_message += alphabet[new_index % 26]
    else
      new_message += char
    end
  end

  new_message
end