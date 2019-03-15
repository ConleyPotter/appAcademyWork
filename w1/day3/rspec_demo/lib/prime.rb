def prime?(num) 
  return false if num < 2

  (2...num).each do |i|
    if num % i == 0
      return false
    end
  end

  true
end