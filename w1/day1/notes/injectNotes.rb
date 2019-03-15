##### Inject Notes ######

### Inject ###

# Ruby's inject method is perhaps the most flexible when it comes to solving
# different problems. To master it's versatility, let's go through the mechanics
# of how inject works. To avoid confusions, we'll refer ot this method as
# inject, but it is also known as reduce in other programming languages.
# Ruby has both an inject and a reduce moethd. Both are funcitonally identical.

### Inject with only a block ###

# The most straightforward way to use inject is to tcall it on an array and pass
# in a block. Like many enumberables, inject will iterate through the array, 
# passing in a the current element ot the block. However, what maeks inject very
# versatile is that the block should accept two parameters, the accumulator
# and the current element. inject will maintain an accumulator that will change
# over time, depending on our block. The block should return what the new
# accumulator should be after a single iteration. Example:

[11, 7, 2, 4].inject { |acc, el| acc + el } 

# Notice that the block params are always in the order of accumulator (acc)
# follow by element (el). Because of how we are calling inject, the initial
# accumulator will be the first element of the array by default. So our first 
# iteration has the acc set to 11 and el set to 7.

# FIRST ITERATION:
# acc = 11
# el = 7
# new_acc = 18
[11, 7, 2, 4].inject { |acc, el| acc + el }

#Since the block results in 11 + 7, 18, will be assigned to acc in the next
# iteration. The el simply iterates to the next elemnt of the array

# SECOND ITERATION:
# acc = 18
# el = 2
# new_acc = 20
[11, 7, 2, 4,].inject { |acc, el| acc + el } 

# Now the acc is 20 and we ahve to do one more iteration for the last el: 

# acc = 20 
# el = 4
# new_acc = 24
p [11,7,2,4].inject { |acc, el| acc + el } # => 24

# Since we are done iterating through al elements, inject will return the 
# final accumulator. We were able to add up all elments of the array 
# using inject! If you're not convinced of how useful injedct is, you're
# probably thinking why don't we use a simpler loop or just use the Array#sum
# method. inject is an awesoem method because of how versaitle it is.

# Applying our same steps as before, we'll leave it to you to ponder how inject
# can also find the total product of an array: 
p [11, 7, 2, 4].inject { |acc, el| acc * el } # => 616

# OR how about finding the minumum value in an array: 

p [11, 7, 2, 4].inject() do |acc, el|
  if el < acc
    el
  else
    acc
  end 
end # => 2

# Because the result of the block is alwasy reassinged ot be the new 
# accumulator, we needed to return the current acc in the even that the el 
# we are iterating through is not smaller than the acc. The lese is neccessary 
# to avoud our block from resulting in nil.

# The key to understanding inject is to remember that the accumulator will be
# reassigned to the result of the blcok on vevery iteration. Because inject
# performs a simple reassignment to the accumulator, we can design any block
# to control how the accumulator should change.

### Inject with a default accumulator ###

# In the last examples we described how the first element of the arry will 
# become the initial accumulator and the first iteration techincally grabs the
# teh second element. We can also use inject by passing in our own initial 
# accumulator. In this scenario, the acc will be our own value and the first
# el will be the first element of the array. Let's make 100 our initial
# accumulator: 

# FIRST ITERATION: 
# acc = 100
# el = 11
# new_acc = 111
[11, 7, 2, 4].inject(100) { |acc, el| acc + el } 

# SECOND ITERATION
# acc = 111
# el = 7
# new_acc = 118
[11, 7, 2, 4,].inject(100) { |acc, el| acc + el }

# THIRD ITERATION
# acc = 118
# el = 2
# new_acc = 120
[11, 7, 2, 4,].inject(100) { |acc, el| acc + el }

# FOURTH ITERATION
# acc = 120
# el = 4
# new_acc = 124
p [11, 7, 2, 4].inject(100) { |acc, el| acc + el } # => 124

# Being able to set our own initial accumulator can really open up our
# possibilities. Here's an inject that sums up all even numbers of an array:

p [11, 7, 2, 4].inject(0) do |acc, el|
  if el.even?
    acc + el
  else
    acc
  end
end # => 6