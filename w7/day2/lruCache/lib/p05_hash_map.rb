require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_accessor :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    unless bucket(key).include?(key)
      bucket(key).append(key,val)
      @count += 1
      if @count > num_buckets
        resize!
      end
    else
      bucket(key).update(key,val)
    end
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    if include?(key)
      bucket(key).remove(key)
      @count -= 1
    end
  end

  def each(&prc)
    @store.each do |ll|
      ll.each do |le|
        prc.call(le.key,le.val)
      end
    end
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    values = []
    num_buckets.times { @store << LinkedList.new }
    @store.each do |bucket|
      while !bucket.empty?
        values << bucket.remove(bucket.first.key)
      end
    end
    values.each do |val|
      bucket(val.key).append(val.key, val.val)
    end
  
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    @store[key.to_s.hash % num_buckets]
  end
end
