class LRUCache
  def initialize(size)
    @size = size
    @cache = []
  end

  def count
    # returns number of elements currently in cache
    @cache.count
  end

  def add(el)
    # adds element to cache according to LRU principle
    if @cache.include?(el)
      return mru(el)
    end
    unless count == @size
      @cache << el
    else
      deleteLRU
      @cache << el
    end
  end

  def show
    # shows the items in the cache, with the LRU item first
    print @cache
  end

  private

  # helper methods go here!
  def deleteLRU
    @cache.shift
  end

  def mru(el)
    @cache.delete_at(@cache.find_index(el))
    @cache << el
  end
end
