require "byebug"

def select_even_nums(array)
  array.select(&:even?)
end

def reject_puppies(array)
  array.reject { |dog| dog["age"] <= 2 }
end

def count_positive_subarrays(two_d_array)
  two_d_array.count { |inner_array| inner_array.sum > 0 }
end

def aba_translate(string)
  new_string = ""
  string.each_char do |char| 
    if "aeiou".include?(char)
      new_string += char + "b" + char
    else
      new_string += char
    end
  end

  new_string
end

def aba_array(array)
  array.map { |word| aba_translate(word) }
end