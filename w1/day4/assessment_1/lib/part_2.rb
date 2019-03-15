def element_count(array)
  letter_hash = Hash.new(0)

  array.each do |string|
    letter_hash[string] += 1
  end

  letter_hash
end

def char_replace!(string, hash)
  string.each_char.with_index { |char, idx| 
    if hash.include?(string[idx])
      string[idx] = hash[char]
    end
  }
end

def product_inject(array)
  array.inject(1) { |accum, el| accum *= el }
end