require "byebug"

class Code
  POSSIBLE_PEGS = {
    "R" => :red,
    "G" => :green,
    "B" => :blue,
    "Y" => :yellow
  }

  attr_reader :pegs

  def self.valid_pegs?(pegs)
    pegs.each do |peg|
      if !POSSIBLE_PEGS.has_key?(peg.upcase)
        return false
      end
    end
    true
  end

  def initialize(pegs)
    if Code.valid_pegs?(pegs)
      @pegs = pegs.map { |el| el.upcase }
    else
      raise "this array contains pegs which are invalid"
    end
  end

  def self.random(length)
    Code.new( Array.new(length) { POSSIBLE_PEGS.keys.sample } )
  end

  def self.from_string(string)
    pegs = string.chars
    Code.new(pegs)
  end

  def [](index)
    @pegs[index]
  end

  def length
    @pegs.length
  end

  def num_exact_matches(guess)
    exact_matches = 0
    @pegs.each.with_index do |peg, idx|
      if @pegs[idx] == guess[idx]
        exact_matches += 1
      end
    end
    exact_matches
  end

  def num_near_matches(guess)
    near_matches = 0
    # debugger
    guess.pegs.each.with_index do |peg, idx|
      if peg != @pegs[idx]
        if @pegs.include?(peg)
          near_matches += 1
        end
      end
    end
    near_matches
  end

  def ==(guess)
    if guess.length != self.length
      return false
    else
      if num_exact_matches(guess) == self.length
        return true
      end
    end
    false
  end
end
