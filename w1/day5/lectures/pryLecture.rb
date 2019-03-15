greens = ["kale", "spinach", "arugula"]

def is_prime?(num)
  (2...num).each do |factor|
    return false if num % factor == 0
  end

  num > 1
end

### load ###

# evaluates to true if it worked

### show-source ###

# you can even use show-source for your own methods after you have loaded
# it into the REPL