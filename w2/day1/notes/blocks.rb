# let's take a closer look at the main feature of the Ruby language: blocks.
# Until this point you have been utilizing blocks with enumberable methods
# like each, map, and times. A block is  achunk of code taht si passed into a 
# method to be executed. We explored blocks in previous sections, but now
# we'll peek under the hood and use blocks in our methods. First, let's do 
# a quick referesher. 

### Block Basics ###

# There are two ways to pass a block into a method. 

# We can use {...} brace syntax for blocks taht only contain a single line
# of code: 

[1,2,3,].map { |num| -(num * 2) } # => [-2, -4, -6]

# Or, we cna use do...end syntax for multiline blocks:

[1,2,3].map do |num|
  double = num * 2
  -doubled
end # => [-2, -4, -6]

# Brace {...} blocks and do...end blocks are functionally equivalent, we just
# prefer do...end for blocks taht contain many lines. 

# Blocks can accept parameters if we name them between pipes ( |param_1, 
# param_2, etc.| ). 

# We know that when we pass a block into map, map will execute the block, passing
# in every element of the array one by one. It will take each evaluation of
# the block and make that value an element of the new array taht the map method
# will return. 

# Blocks are somewhat similar to methods in that both can contain lines of 
# code as well as take in parameters. However, an important distinction to make is 
# that the return keywork pertains to methods, not blocks.

# Correct:
def double_eles(arr)
  arr.map do |ele|
    ele * 2
  end
end
double_eles([1,2,3]) #=> [2,4,6]


# Incorrect:
def double_eles(arr)
  arr.map do |ele|
    return ele * 2
  end
end
double_eles([1,2,3]) #=> 2

# Looking at the incorrect implementation of double_eles, we use the return
# keywork within the blcok. If we will be returning out of the entire double_eles
# method on the first iteration of map.

### Using methods as Blocks ###

# It is very, very common to have blcoks that take an argument and call a single
# method. For example: 

["a", "b", "c"].map { |str| str.upcase }  #=> ["A", "B", "C"]
[1, 2, 5].select { |num| num.odd? }       #=> [1, 5]

# Ruby allows use to use cleaner syntax when we have simple blocks that
# follow the above pattern. Let's refactor the above example to use this shortcut:

["a", "b", "c"].map(&:upcase) # => ["A","B","C"]
[1,2,5].select(&:odd?)        # => [1,5]

# You may find this syntax quite strange. Let's notice a few things about how we 
# are using map. We call map and pass in a single argument, &:upcase. :upcase is 
# a symbol referring to the String#upcase method. We use & to convert this "method" 
# into an object that we can pass into map. In Ruby, we cannot directly pass a 
# method into another method, so we need to use the & operator. In the next lecture 
# we'll explore the intricacies of &.

# For now, here's a hard and fast rule you can use to optimize some blocks. 
# If you are calling a method likle map, passing a block that has this general
# structure:

array.map { |block_param| block_param.method }

# Then you can rewrite it as: 

array.map(&:method)

# When employing this trick, be aware of what &:method you are using. The
# method you choose should be compatible with your data:

"a", "b", "c"].map(&:upcase) # => ["A", "B", "C"]
[1, 2, 3].map(&:upcase)       # NoMethodError: undefined method 'upcase' for Integer


# The second map is invalid because we cant us upcase on numbers!


