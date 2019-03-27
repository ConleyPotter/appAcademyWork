class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    unless include?(key)
      self[key].push(key.hash)
      @count += 1
    end
    if @count > num_buckets
      resize!
    end
  end

  def include?(key)
     @store.each do |bucket|
       return true if bucket.include?(key.hash)
     end
     false
  end

  def remove(key)
    if include?(key)
      self[key].delete(key.hash)
      @count -= 1
    end
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
     @store[num.hash % num_buckets]
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
