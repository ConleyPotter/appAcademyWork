# Monkey-Patch Ruby's existing Array class to add your own custom methods
class Array
  def span
    if self.length > 0
      return self.max - self.min
    else
      return nil
    end
  end

  ### WALKTHROUGH SOLUTION ###

  def span
    return nil if self.empty? 
    self.max - self.min
  end

  def average
    return nil if self.empty? 
    self.sum / (self.length * 1.0)
  end

  def median
    mid_index = self.length / 2
    sorted = self.sort
    if self.length.odd? 
      return sorted[mid_index]
    else
      first_el = sorted[mid_index]
      second_el = sorted[mid_index + 1]
      return (first_el + second_el) / 2.0
    end
  end 

  def counts
    count_hash = Hash.new { |hash, key| hash[key] = 0 }
    self.each { |el| count_hash[el] += 1 }
    count_hash
  end

  def my_count(val)
    return self.counts[val]
  end

  def my_index(val)=
    self.each_with_index do |el, idx| 
      if el == val
        return idx
      end
    end

    nil
  end

  def my_uniq
    new_array = []

    self.each do |el|
      if !new_array.include?(el)
        new_array << el
      end
    end

    new_array
  end

  def my_uniq
    hash = {}
    self.each { |el| hash[el] = true }
    hash.keys
  end

  def my_transpose
    vert_counter = 0
    transposed_array = Array.new(self[0].length) { Array.new(self[1].length) }

    while vert_counter < self[1].length 
      horiz_counter = 0

      while horiz_counter < self[0].length
        transposed_array[horiz_counter][vert_counter] = self[vert_counter][horiz_counter]
        horiz_counter += 1
      end

      vert_counter += 1
    end

    transposed_array
  end
end
