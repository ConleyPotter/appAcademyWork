### DAY 1 TIPS AND TRICKS ###

# 1.) Remember that common enumberables: any?, all?, none?, one?, etc.

# 2.) Rememember that complex logic can be done inside blocks even on one line

# 3.) .. is an inclusive range, ... excludes the ending index 

# 4.) Even if you are defining a hash using the symbol: value trick to omit
# the colon at the beginning of the symbol and the =>, don't forget when you are
# indexing a hash like hash[:sybol] the colon at the beginning of the symbol is 
# still required

# 5.) Have fun! Relax! (I originally left this blank :|)

# 6.) Strings have an include? method String#include?(char). Strings also have
# the String#chars method which split the string into an array of its characters

# 7.) To make an argument have a default value, just set it equal to that default
# in the parameter defintions: 
def method(arg1, arg2=default_value)

# 8.) the select method for arrays is a handy one, and Array#select! actually
# mutates the array

# 9.) 
array.inject(startingValue) { |accumulator, element| accumulator + element }
# is a quick way to sum up an array without using the built in Array#sum

# 10.) inject can also be used to find the max without using Array#inject:

def max_inject(*arr) 
  arr.inject(0) do |acc, el|
    if el > acc
      el
    else
      acc
    end
  end
end

# 11.) The splat operator * has many uses, one of the best is to except an 
# unlimited amount of arguments in a method. It will take all of the arguments
# you give it and convert those into an array with the name of the argument after
# the splat:

def union(*arrays) 
  arrays.flatten
end

# takes in two (or three, or as many as you want) arrays and pushes them into one
# array

### DAY 2 TIPS AND TRICKS ###

# 1.) Remember that you can perform multiple simultaneous assignments using a comma

# 2.) for loops are frowned upon, use each and a range! 

# DISLIKED BY RUBYISTS: #
def is_sorted(arr)
  for i in (0...arr.length - 1)
    if arr[i]> arr[i + 1]
      return false
    end
  end
  
  true
end

# PREFERRED: 
def is_sorted(arr)
  (0...arr.length - 1).each do |i|
    ...

# 3.) The bubble sort algorithm uses the two bullets above, and assumes that if
# a switch has been done, like in the case of bullet 1 with multiple reassignments
# on one line, that the array is still not sorted, so it sets a sorted flag to false

# 4.) Use enumberables wherever possible, and remember that most have
# a method called .with_index, where, within the do block, you can identify
# an index variable to keep track of the current index

# 5.) While loops are the the preferred loops, think of the compress string
# function, where you really want to know which of the characters ahead of the 
# current character are repeating. there you want an index to keep track of, but 
# you want to control where that counter is, and want to control when to increment it

# 6.) most methods of Array and String, like map, select, etc, have a second
# almost identical version with a ! after, do denote that it does the method in place
# as opposed to creating a copy when doing so. use them when data integrity is
# important.

# 7.) always check for edge cases, like in the my_rotate!(array, amt) method, 
# check for the case that the amount is negative, denoting a right shift instead
# of a left. you can check the value of amt, is it less than or greater than 0, 
# then you can reverse the rotation logically, doing it with the absolute value
# of amt

### DAY 3 TIPS AND TRICKS ###

# 1.) If you need to perform float division instead of floor, just divide by a Float

# 2.) Always run rspec after setting up the method with just the name, arguments
# and an end, to make sure you've named the method correctly

# 3.) the command to run rspec is: bundle exec rspec

# 4.) You may need to go into Gemfile.lock and change the bundler version to 2.0.1
# at the bottom of the file

# 5.) a range can be created for letters, remember ruby is smart so:
("a..z").to_a  == ["a", "b", "c"...]

# 6.) array has a method Array#index which will return the index of the value passed

