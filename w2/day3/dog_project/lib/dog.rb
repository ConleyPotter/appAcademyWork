class Dog
  def initialize(name, breed, age, bark, favorite_foods)
    @name = name
    @breed = breed
    @age = age
    @bark = bark
    @favorite_foods = favorite_foods
  end

  def name
    @name
  end

  def breed
    @breed
  end

  def age
    @age
  end

  def age=(age)
    @age = age
  end

  def bark
    if @age > 3
      return @bark.upcase
    elsif @age <= 3
      return @bark.downcase
    else
      return nil
    end
  end

  def favorite_foods
    @favorite_foods
  end

  def favorite_food?(item)
    if favorite_foods.include?(item.capitalize)
      return true
    else
      return false
    end
  end

  ### WALKTHROUGH SOLUTION ###
  def favorite_food?(item)
    @favorite_foods.map(&:downcase).include?(item.downcase)
  end
end
