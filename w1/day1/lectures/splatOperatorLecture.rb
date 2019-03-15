##### Splat Operator Lecture #####

def say_hello(first_name, last_name) 
  p first_name
  p last_name
end

say_hello("alvin", "zablan")

# this method expects two arguments

# say_hello("alvin", "zablan", "teacher") splatOperatorLecture.rb:3:in `say_hello': wrong number of arguments (given 3, expected 2) (ArgumentError)
      #  from splatOperatorLecture.rb:12:in `<main>'

# TERMINOLOGY: a parameter is first_name ie, an argument is "alvin" ie
# a parameter is the abstract placeholder, the argument is the actual data

def say_hello1(first_name, *other_args) 
  p first_name
  p other_args
end

say_hello1("alvin", "zablan", "teacher")

# OUTPUT: "alvin"
        # ["zablan", "teacher"]

### Unpacking an existing array ###

def say_hello2(first_name, last_name) 
  p first_name
  p last_name
end

arr = [ "a", "z" ]
say_hello2(*arr)
# OUTPUT: "a"
        # "z"

# Think of the splat as removing the brackets from arr ie

teachers = ["oliver", "simcha", "tommy"] 
new_teachers = [ *teachers, "molly", "abby"]

p new_teachers
# OUTPUT: ["oliver", "simcha", "tommy", "molly", "abby"]

### Double splat ###

hash = { a: 1, b: 2 }
new_hash = { **hash, c:3, d:4 }

p new_hash
# OUTPUT: {:a=>1, :b=>2, :c=>3, :d=>4}

# the keys need to symbols if you are going to use the double splat to unpack