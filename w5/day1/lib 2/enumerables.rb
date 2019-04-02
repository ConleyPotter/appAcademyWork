require "byebug"

class Array

    def my_each(&prc)
        idx = 0
        while idx < self.length
            prc.call(self[idx])
            idx += 1
        end
        self
    end

    def my_select(&prc)
        selected = []
        self.my_each do |el|
            if prc.call(el)
                selected << el
            end
        end
        selected
    end

    def my_reject(&prc)
        selected = []
        self.my_each do |el|
            unless prc.call(el)
                selected << el
            end
        end
        selected
    end

    def my_any?(&prc)
        self.my_each do |el|
            return true if prc.call(el)
        end
        false
    end

    def my_all?(&prc)
        self.my_each do |el|
            return false if !prc.call(el)
        end
        true
    end

    def my_flatten
        flattened = []
        self.each do |el| 
            if el.instance_of? Array
                flattened += el.my_flatten
            else
                flattened << el
            end
        end
        flattened
    end

    def my_zip(*arrays)
        zipped = []
        self.each_with_index do |el, idx|
            inner = [el]
            arrays.each do |passed_array|
                inner << passed_array[idx]
            end
            zipped << inner
        end
        zipped
    end

    def my_rotate(rotations=1)
        if rotations > 0
            rotations.times do
                self << self.shift
            end
        else
            (-1 * rotations).times do 
                self.unshift(self.pop)
            end
        end
    end

    def my_join(separator="")
        joined = ""
        self.each do |el|
            if el == self.last
                joined += el
            else
                joined += (el + separator)
            end
        end
        joined
    end

    def my_reverse
        reversed = []
        self.length.times do
            reversed << self.pop
        end
        reversed
    end

    def bubble_sort!(&prc)
        sorted = false
        until sorted
            sorted = true
            (0...self.length - 1).each do |idx|
                if prc.call(self[idx], self[idx + 1]) == 1
                    self[idx], self[idx + 1] = self[idx + 1], self[idx]
                    sorted = false
                end
            end
        end
        self
    end

    def bubble_sort(&prc)
        # After writing `bubble_sort!`, write a `bubble_sort` that does the same
        # but doesn't modify the original. Do this in two lines using `dup`.
        final_result = self.dup
        final_result.bubble_sort!(&prc)
    end

end



def factors(num)
    factors = []
    (1..num).each do |el|
        if num % el == 0
            factors << el
        end
    end
    factors
end

def substrings(string)
    substrings = []
    (0...string.length).each do |idx|
        (1..string.length - idx).each do |length|
            substrings << string[idx, length]
        end
    end
    substrings
end

def subwords(word, dictionary)
    sub_words = []
    sub_words = substrings(word)
    sub_words.select{|word| dictionary.include?(word)}
end


array = [2, 5, 7]
p array.my_select {|el| el < 5}
p array
p array.my_reject {|el| el < 5}
p array.my_any?{|el| el < 5}
p array.my_all?{|el| el < 5}
p array.my_all?{|el| el < 8}

array_1 = [[1],[2],[3,4]]
p array_1.my_flatten
a = [4, 5, 6]
b = [7, 8, 9]
p [1, 2, 3].my_zip(a, b)
p [1, 2].my_zip([8])

a = [ "a", "b", "c", "d" ]
a.my_rotate         #=> ["b", "c", "d", "a"]
# p a
a.my_rotate(2)      #=> ["c", "d", "a", "b"]
a.my_rotate(-3)     #=> ["b", "c", "d", "a"]
a.my_rotate(15)     #=> ["d", "a", "b", "c"]
p a

a = [ "a", "b", "c", "d" ]
p a.my_join         # => "abcd"
p a.my_join("$")    # => "a$b$c$d"

p [ "a", "b", "c" ].my_reverse   #=> ["c", "b", "a"]
p [ 1 ].my_reverse               #=> [1]

a = [1,2,3,4]

a.bubble_sort { |num1, num2| num2 <=> num1 }