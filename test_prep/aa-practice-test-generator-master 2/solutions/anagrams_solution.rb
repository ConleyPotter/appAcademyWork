def anagrams(str1, str2)
  letters = Hash.new(0)

  str1.split('').my_each do |char|
    letters[char] += 1
  end

  str2.split('').my_each do |char|
    letters[char] -= 1
  end

  letters.all? { |_, v| v.zero? }
end