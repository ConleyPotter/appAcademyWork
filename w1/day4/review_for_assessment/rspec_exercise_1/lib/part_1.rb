def average(num_1, num_2)
  return (num_1 + num_2) / 2.0
end

def average_array(array)
  array.inject(0) { |accum, el| accum + el } / array.length.to_f
end

def repeat(string, num)
  return string * num
end

def yell(string)
  return string.upcase + "!"
end

def alternating_case(string)
  words = string.split(" ")

  new_words = words.map.with_index do |word, idx|
    if idx % 2 == 0
      word.upcase
    else
      word.downcase
    end
  end

  new_words.join(" ")  
end

