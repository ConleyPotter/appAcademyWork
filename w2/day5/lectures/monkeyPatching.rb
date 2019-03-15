# Monkey Patching - Adding additional methods to an existing class 

# Ruby Types are really classes: Integer, string, array, hash, etc...

class String
  def upcase?
    self.upcase == self
  end
end

p "hello".upcase?             # false
p "HELLO".upcase?             # true

class Integer
  def prime?
    if self < 2
      return false
    end

    (2...self).each do |factor|
      if self % factor == 0
        return false
      end
    end

    true
  end
end

p 7.prime?                    # true
p 11.prime?                   # true
p 12.prime?                   # false

class Array
  def has_zero?
    self.include?(0)
  end
end

[4,2,3,0, "hello"].has_zero?  # true
[4,3,3, "hello"].has_zero?    # fasle