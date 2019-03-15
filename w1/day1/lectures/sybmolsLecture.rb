##### SYMBOLS LECTURE #####

# how to denote a symbol in ruby:

sym = :hello
str = "hello"

p sym.length
p str.length

p sym[1]
p str[1]

# symbols are immutable - cannot change
# strings are mutable - can change

str[1] = "x"
# sym[1] = "x" will not work, will throw error
p str
p sym

p "hello".object_id
p "hello".object_id
p "hello".object_id # all id's will be different

p :hello.object_id
p :hello.object_id
p :hello.object_id # all id's will be the same

bootcamp = { :name=>"app academy", :color=>"red" }
p bootcamp[:color] # => "red"
p bootcamp

bootcamp1 = { name:"map academy", color:"blue" } # the keys are still symbols
p bootcamp1[:color] # still need to reference the symbol the same way
# short hand is only for initializing in a hash
p bootcamp1

# symbols are more efficient, use when I want quick lookup