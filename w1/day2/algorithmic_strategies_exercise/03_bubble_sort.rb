# Reimplement the bubble sort outlined in the preceding lecture.
# The bubble_sort method should accept an array of numbers and arrange the elements in increasing order.
# The method should return the array.
# Do not use the built-in Array#sort

def bubble_sort(array) 
  sorted = false                                          # start off with the assumption that it's not sorted

  while !sorted
    sorted = true 

    (0...array.length - 1).each do |i|                     # and then loop through every index, minus the last
        if array[i] > array[i + 1]                        # if the first index has a greater value than the second
          array[i], array[i + 1] = array[i + 1], array[i] # switch it
        sorted = false                                    # since a switch needed to happen, it is not sorted yet
      end
    end
  end

  array                                                   # return the sorted array
end

p bubble_sort([2, 8, 5, 2, 6])      # => [2, 2, 5, 6, 8]
p bubble_sort([10, 8, 7, 1, 2, 3])  # => [1, 2, 3, 7, 8, 10]