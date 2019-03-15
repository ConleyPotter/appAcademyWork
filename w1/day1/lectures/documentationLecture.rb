##### Using Documentation: Ruby-Doc

### All? ###
p [2,4,6].all? { |num| num.even? } # => true
p [2,4,6,7].all? { |num| num.even? } # => false

### Any? ###
p [2,3,4,5,6].any? { |num| num.even? } # => true
p [3,5,7].any? { |num| num.even? } # => false

### none? ###
p [3,5,5,7].none? { |num| num.even? } # => true
p [3,5,5,6,7].none? { |num| num.even? }  # => false

### count ###
p [3,6,5,7].count { |num| num.even? } # => 1
p [3,6,5,7,8].count { |num| num.even? } # => 2