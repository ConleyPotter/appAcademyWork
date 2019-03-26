def chop_add(num1, num2)
  num1 = num1 / 5.0      # 1 (mem access) + 1 (mem access) + 1 (division op)
  num2 = num2 / 5.0      # 1 (mem access) + 1 (mem access) + 1 (division op)

  300.times do # 300(3 + 3)
    num1 = num1 / 2
    num2 = num2 / 2
  end

  sum = num1 + num2      # 4

  300.tiemes { sum = sum * 2 }

  sum * 5
end                 # chop_add = 2710 steps

def iter_add(num1, num2)
  num1.times { num2 += 1 }
  num2
  # ...
end                 # iter add = 3n + 1

### so which is better? ###

# that depends on the input size, becuase chop_add is input size agnostic
# if the input size is greater than x, then chop_add is faster

# asymptotic = approaching a value abitrarily close
# the behavior of a line as it approaches its limit (infinity)

### ignore all the constants ###

# a constant may shift around a line on a graph, but it does not change the
# behavior of the line

### only consider the most dominant term ###

# 3n + 1 - n is the most dominant term
# as n becomes larger, 1 becomes less significant

### looking at the above asymptotically: ###

# 2710: ignore constants, its nuntime is 1
# 3n + 1: ignore 3 and 1, they are constants, so its runtime is n
