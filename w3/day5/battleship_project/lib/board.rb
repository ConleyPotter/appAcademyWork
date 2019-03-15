require 'byebug'

class Board

  attr_reader :size

  def initialize(n)
    @grid = Array.new(n) { Array.new(n) { :N } }
    @size = n ** 2
  end

  def [](inidices)
    @grid[inidices[0]][inidices[1]]
  end

  def []=(position, value)
    @grid[position[0]][position[1]] = value
  end

  def num_ships
    num_ships = @grid.flatten.count(:S)
  end

  def attack(position)
    # debugger
    if self[position] == :S
      self[position] = :H
      p "you sunk my battleship!"
      return true
    else
      self[position] = :X
      return false
    end
  end

  def place_random_ships
    ship_count = self.size * 0.25
    while ship_count > 0
      random_row = Random.rand(Math.sqrt(self.size).round)
      random_pos = Random.rand(Math.sqrt(self.size).round)
      if self[[random_row, random_pos]] == :S
        next
      else
        self[[random_row, random_pos]] = :S
      end
      ship_count -= 1
    end
  end

  def hidden_ships_grid
    @grid.map do |row|
      row.map do |el|
        if el == :S
          :N
        else
          el
        end
      end
    end
  end

  def self.print_grid(grid)
    grid.each do |row|
      row.each.with_index do |el, idx|
        print el
        if idx < row.length - 1
          print " "
        end
      end
      print "\n"
    end
  end

  def cheat
    Board.print_grid(@grid)
  end

  def print
    Board.print_grid(self.hidden_ships_grid)
  end
end
