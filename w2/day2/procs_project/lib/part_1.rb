def my_map(array, &prc)
  result = []
  array.each { |el| result << prc.call(el) }
  result
end

def my_select(array, &prc)
  result = []
  array.each { |el| result << el if prc.call(el) }
  result
end

def my_count(array, &prc)
  counter = 0
  array.each { |el| counter += 1 if prc.call(el) }
  counter
end

def my_any?(array, &prc)
  array.each { |el| return true if prc.call(el) } 
  false
end

def my_all?(array, &prc)
  array.each { |el| return false if !prc.call(el) }
  true
end

def my_none?(array, &prc)
  array.each { |el| return false if prc.call(el) }
  true
end