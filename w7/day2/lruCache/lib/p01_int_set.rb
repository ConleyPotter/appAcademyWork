require 'byebug'

class MaxIntSet
  def initialize(max)
    @store = Array.new(max,false)
  end

  def insert(num)
    raise 'Out of bounds' if !num.between?(0,@store.length)  
    @store[num] = true
  end

  def remove(num)
     @store[num] = false
  end

  def include?(num)
     @store[num]
  end

  private

  def is_valid?(num)
  end

  def validate!(num)
  end
end


class IntSet
  attr_reader :store
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % @store.length]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    if !include?(num)
      self[num] << num 
      @count += 1
    end
    if @count > num_buckets
      resize!
    end
  end

  def remove(num)
    if include?(num)
      self[num].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    self[num].include?(num)
  end


  private

  def [](num)
    @store[num % @store.length]
  end

  def num_buckets
    @store.length
  end

  def resize!
    values = []
    num_buckets.times { @store << [] }
    @store.each do |bucket|
      while !bucket.empty?
        values << bucket.delete_at(0)
      end
    end
    values.each do |val|
      self[val] << val
    end
  end
end
