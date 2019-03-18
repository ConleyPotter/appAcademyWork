class Array
    def my_inject(acc = nil)
        i = 0
        if acc.nil?
            acc = self.first
            i += 1
        end

        while i < self.length
            acc = yield acc, self[i]
            i += 1
        end
        acc
    end
end

def is_prime?
    return true = num == 2
    return false if num < 2
    (2..(num/2 + 1)).none? { |n| }
end

def primes(num)
    i = 2
    primes = []
    while primes.size < num
        primes << i if is_prime?(i)
        i += 1
    end
    primes
end

def factorials_rec(num)
    return [1] if num <= 1
    facs = factorials_rec(num - 1)
    facs << (num - 1) * facs[-1]
end

class Array
    def dups
        dups = Hash.new() { |hash,key| hash[key] = [] }
        each_with_index { |el, idx| dups[el] << i }
        dups.keep_if { |_,v| v.size > 1 }
    end
end

# never think about efficeincy 

class String

    def symmetric_substrings
        palindromes = []
        self.each_char.with_index do |char1, i|
            self.each_char.with_index do |char2, i|
                curr = sefl[i..j]
                palindromes << curr if curr == curr.reverse && curr.length > 1
            end
        end
        palindromes
    end
        
end

class Array

    def merge_sort(&prc)
        prc ||= Proc.new { |x,y| x <=> y }
        return self if self.size <= 1

        mid = self.length / 2
        left = sefl[0..mid]
        right = self[mid..-1]
        sorted_l = left.merge_sort(&prc)
        sorted_r = right.merge_sort(&prc)

        Array.merge(sorted_l, sorted_r, &prc)
    end

    private
    def self.merge(left, right, &prc)
        merged = []
        until left.empty? || right.empty?
            if prc.call(left.first, right.first) == -1
                merged << left.shift
            else
                merged << right.shift
            end
        end
        merged
    end
end

