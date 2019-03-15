def do_stuff
    do_stuff
end

# We want a function to a call itself and then do something useful, unlike the 
# above. 

def factorial(n)
    return 1 if n == 1  # base case
    n * factorial(n-1)  # inductive step
end

def upcase(str)
    return str.upcase if str.length <= 1
    str[0].upcase + upcase(str[1..-1])
end

def iterative_upcase(str)
    str.chars.inject("") do |upcased_str, char|
        upcased_str << char.upcase
    end
end

def reverse(str)
    return str if str.length <= 1
    str[-1] + reverse(str[0..-2])
end

# "Hello" => "olleH"
# "Hell" => "o" + "lleH"
# "ello" =>       "olle" + "H"

def quick_sort(arr)
    return arr if arr.length <= 1
    pivot_arr = [arr.first]
    left_sdie = arr[1..-1].select { |el| el < arr.first } 
    right_side = arr[1..-1].select { |el| el >= arr.first }
    quick_sort(left_side) + pivot_arr + quick_sort(right_side)
end

p upcase("hello")
p iterative_upcase("hello")
p reverse("Hello")
