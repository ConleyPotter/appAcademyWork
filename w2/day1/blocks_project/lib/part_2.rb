def all_words_capitalized?(array)
  array.all? { | word| word[0] == word[0].upcase && word[1] == word[1].downcase }
end

### WALKTHROUGH SOLUTION

def all_words_capitalized?(array)
  array.all? { |word| word.capitalize == word }

def is_valid_url?(url)
  url_endings = [".com", ".net", ".io", ".org"]

  url_endings.each do |url_ending| 
    return true if url.include?(url_ending) 
  end

  false
end

def no_valid_url?(urls)
  urls.none? { |url| is_valid_url?(url) }
end

def any_passing_students?(students)
  students.any? { |student| student[:grades].sum / student[:grades].length > 75 }
end