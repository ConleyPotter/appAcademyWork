class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    initial_value = 100
    self.each_with_index do |ele, idx|
      initial_value += (((ele.hash) ^ (idx)).to_s(2)).to_i
      
    end 
    return initial_value
  end
end

class String
  def hash
    chars = self.chars
    results = 0
    chars.each_with_index do |char, idx|
      results += ((char.ord ^ idx).to_s(2)).to_i
    end
    results
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    pairs = []
    self.each_pair do |key,value|
      pair = [key.to_s,value]
      pairs << pair
    end
    pairs.map do |pair|
      pair.hash
    end
    pairs.hash
  end
end
