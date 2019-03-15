require 'byebug'

### Pass by reference ###

# immutable: Integer, floats, booleans, nilClass
# mutable: String, arrays, hash, set

ruby_love = ["I", "Love", "Ruby"]

ruby_love.each { |word| word += "!" }

# += creates a new variables, does not change the word

