def reverser(string, &prc)
  prc.call(string.reverse)
end

def word_changer(sentence, &prc) 
  words = sentence.split(" ")
  new_setence = []
  words.each { |word| new_setence << prc.call(word) }
  new_setence.join(" ")
end

def greater_proc_value(number, prc_1, prc_2)
  number_version_1 = prc_1.call(number)
  number_version_2 = prc_2.call(number)
  number_version_1 > number_version_2 ? number_version_1 : number_version_2
end

def and_selector(array, prc_1, prc_2)
  new_array = []
  array.each { |el| new_array << el if prc_1.call(el) && prc_2.call(el) }
  new_array
end

def alternating_mapper(array, prc_1, prc_2)
  new_array = []
  array.each_with_index do |el, idx|
    if idx % 2 == 0
      new_array << prc_1.call(el)
    else
      new_array << prc_2.call(el)
    end
  end
  new_array
end
