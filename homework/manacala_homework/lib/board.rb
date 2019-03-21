require 'byebug'

class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @player1 = name1
    @player2 = name2
    @cups = Array.new(14) { [] }
    place_stones
  end

  def place_stones
      @cups.map!.with_index do |cup, idx| 
      if [6,13].include?(idx)
        cup
      else
        [:stone, :stone, :stone, :stone]
      end
    end
  end

  def valid_move?(start_pos)
    if !start_pos.between?(0,13)
      raise "Invalid starting cup"
    elsif @cups[start_pos - 1].empty?
      raise "Starting cup is empty"
    else
    end
  end

  def make_move(start_pos, current_player_name)
    stones_in_start_pos = @cups[start_pos]
    opponents_score_store = current_player_name == @player1 ? 13 : 6
    player_cup = opponents_score_store == 6 ? 13 :6
    @cups[start_pos] = []
    i = start_pos
    until stones_in_start_pos.empty?
      i += 1
      i = 0 if i > 13
      @cups[i] << stones_in_start_pos.shift unless i == opponents_score_store
    end
    render
    next_turn(i)
    if i == player_cup
      return :prompt
    elsif @cups[i].size == 1
      return :switch
    else
      return i
    end

    # @cups[start_pos].reject! { |el| el && stones_in_start_pos += 1}
    # # seeing what side belongs to the current player
    # current_players_side = current_player_name == @player1 ? :side1 : :side2
    # # this loop iterates while there are stones left to distribute
    # (1..stones_in_start_pos).each do |cup_incrementer|
    #   # modulo by 13 so that we loop around the board when we reach the 13th(14th) cup
    #   cup_idx = (start_pos + cup_incrementer) % 14
    #   # don't place stones in the opponents point cup
    #   if current_players_side == :side1
    #     if cup_idx == 13
    #       cup_incrementer += 1
    #       ending_cup_idx += 1
    #     else
    #       @cups[cup_idx] << :stone 
    #     end
    #   else
    #     if cup_idx == 6
    #       cup_incrementer += 1
    #       ending_cup_idx += 1
    #     else
    #       @cups[cup_idx] << :stone 
    #     end
    #   end
    #   ending_cup_idx += 1
    # end
    # ending_cup_idx %= 14
    # render
    # self.next_turn(ending_cup_idx)
  end

  def next_turn(ending_cup_idx)
    # helper method to determine whether #make_move returns :switch, :prompt, or ending_cup_idx
    # if @cups[ending_cup_idx].empty?
    #   return :switch
    # elsif ending_cup_idx == 13 || ending_cup_idx == 6
    #   return :prompt
    # else
    #   return ending_cup_idx
    # end
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    (0..5).all? { |idx| @cups[idx].empty? } || (7..12).all? { |idx| @cups[idx].empty? }
  end

  def winner
    if @cups[6].size == @cups[13].size
      return :draw
    else
      if @cups[6].size > @cups[13].size
        return @player1
      else
        return @player2
      end
    end
    
    # if !one_side_empty?
    #   return :draw
    # else
    #   if @cups[0].empty?
    #     return @player1
    #   else
    #     return @player2
    #   end
    # end
  end
end
