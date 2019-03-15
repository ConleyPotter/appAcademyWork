##### Bubble Sort Lecture #####

def bubble_sort(array) 
  sorted = false

  while !sorted
    sorted = true
    (0...array.length - 1).each do |i|
      if array[i] > array[i + 1]  # if the adj elememts are OUT OF ORDER
        array[i], array[i + 1] = array[i + 1], array[i]
        sorted = false
      end
    end
  end

  array
end

array = [2, 8, 5, 2, 6]
p bubble_sort(array) # => [2, 2, 5, 6, 8]