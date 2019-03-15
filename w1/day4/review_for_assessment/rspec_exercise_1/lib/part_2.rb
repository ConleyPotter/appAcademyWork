def hipsterfy(string)
  vowels = 'aeiou'
  i = string.length - 1

  while i >= 0
    if vowels.include?(string[i])
      return string[0...i] + string[i+1..-1]
    end

    i -= 1
  end

  string
end

def vowel_counts(string)
  vowels = "aeiou"
  vowel_hash = Hash.new(0)

  for i in (0..string.length - 1)
    if vowels.include?(string[i].downcase)
      vowel_hash[string[i].downcase] += 1
    end
  end

  vowel_hash
end

def caesar_cipher(message, n)
  alpha_hash = ("a".."z").to_a
  new_message = ""

  message.each_char do |char|
    if alpha_hash.include?(char)
      old_index = alpha_hash.index(char)
      new_index = old_index + n
      new_message += alpha_hash[new_index % 26]
    else
      new_message += char
    end
  end

  new_message
end
