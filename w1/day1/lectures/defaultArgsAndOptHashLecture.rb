##### Default Arguments and Optional Hashes Lecture #####

def repeat(str, n) 
  p str * n
end

p "HELLO" * 4
repeat("HELLO", 4) # this and the above are the same

# no need to pass in a number if you don't want to repeat
def repeat(str, n=1)
  p str * n
end

def print_h(hash) 

  p hash

end

print_h({"city"=>"NY", "color"=>"red"})
print_h("city"=>"NY", "color"=>"red") # You can drop the braces when passing a hash

def print_h(name, hash)
  p name 
  p hash
end

print_h("alvin", "city"=>"NY", "color"=>"red") # will recognize the hash
# OUTPUT:
## "alvin"
## {"city"=>"NY", "color"=>"red"}