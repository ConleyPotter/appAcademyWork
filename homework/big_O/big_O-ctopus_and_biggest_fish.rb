fish = ["fish", "fiiish", "fiiiiish", "fiiiish", "fffish", "ffiiiiisshh", "fsh", "fiiiissshhhhhh"]
### Sluggish Octopus ###
# Find the longest fish in O(n^2) time. Do this by comparing all fish lengths
# to all other fish lengths

def sluggish_octupus(fish)
  biggest_fish = nil
  (0...fish.size - 1).each do |first_fish|
    (first_fish...fish.size).each do |second_fish|
      if first_fish.length > second_fish.length
        biggest_fish = first_fish
      else
        biggest_fish = second_fish
      end
    end
  end
  biggest_fish
end

# Dominant octupus

def merge_sort(fish, &prc)
  return fish if fish.size <= 1

  middle = fish.size / 2

  left = merge_sort(fish.take(middle), &prc)
  right = merge_sort(fish.drop(middle), &prc)

  merge(left, right, &prc)
end

def merge(left, right, &prc)
  merged = []
  prc ||= Proc.new { |num1, num2| num1.length <=> num2.length }
  until left.empty? || right.empty?
    case prc.call(left.first, right.first)
    when -1
      merged << left.shift
    when 0
      merged << left.shift
    when 1
      merged << right.shift
    end
  end

  merged + left + right
end

# Dancing Octopus
tiles_array = ["up", "right-up", "right", "right-down", "down", "left-down", "left", "left-up"]

def slow_dance(direction, tiles)
  i = 0
  until tiles[i] == direction
    i += 1
  end
  i
end

new_tiles_data_structure = {
  "up" => 0,
  "right-up" => 1,
  "right" => 2,
  "right-down" => 3,
  "down" => 4,
  "left-down" => 5,
  "left" => 6,
  "left-up" => 7,
}

def fast_dance(direction, tiles)
  tiles[direction]
end
