# Write a method, compress_str(str), that accepts a string as an arg.
# The method should return a new str where streaks of consecutive characters are compressed.
# For example "aaabbc" is compressed to "3a2bc".

def compress_str(str)
  repeats = []
  new_str = ""

  (1..str.length).each do |idx|
    if str[idx] == str[idx - 1]
      repeats << str[idx - 1] 
    elsif str[idx] != str[idx - 1]
      if repeats.include?(str[idx - 1])
        repeats << str[idx - 1]
        counter = repeats.length
        new_str << (counter.to_s + repeats[0])
      else
        new_str << str[idx - 1]
      end
      repeats = []
    end
  end
  
  new_str
end

### WALKTHROUGH SOLUTION ###

def compress_str(str) 
  compressed = ""

  while i < str.length
    char = str[i]
    count = 0
    while char == str[i]
      count += 1
      i += 1
    end
    if count < 1
      compressed += count.to_s + char
    else
      compressed += char
    end
    
  end

  compressed
end

p compress_str("aaabbc")        # => "3a2bc"
p compress_str("xxyyyyzz")      # => "2x4y2z"
p compress_str("qqqqq")         # => "5q"
p compress_str("mississippi")   # => "mi2si2si2pi"
