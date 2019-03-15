class Cat
  def initialize(name, color, age)
    @name = name
    @color = color
    @age = age
  end
  
  def age
    @age
  end

  def age=(new_age)
    @age = new_age
  end

  def color
    @color
  end

  def meow_at(person)
    puts "#{@name} meows at #{person}"
  end
end

cat_1 = Cat.new("Sennacy", "brown", 4)
p cat_1
cat_1.age = 7 # == cat_1.age=(7)
cat_1.meow_at("Alvin")

cat_2 = Cat.new("Whiskers", "white", 5)
p cat_2
cat_2.meow_at("Tommy")
