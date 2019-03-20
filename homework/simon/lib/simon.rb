class Simon
  COLORS = %w(red blue green yellow)

  attr_accessor :sequence_length, :game_over, :seq

  def initialize
    @sequence_length = 1
    @game_over = false
    @seq = []
  end

  def play
    until game_over
      take_turn
    end
    game_over_message
    reset_game
  end

  def take_turn
    show_sequence
    require_sequence
    unless game_over
      round_success_message 
      @sequence_length += 1
    end
  end

  def show_sequence
    add_random_color
    puts seq.join(" ")
    sleep 4
    puts `clear`
  end

  def require_sequence
    puts "Repeat back the sequence you just saw"
    sequence_repeated_back = gets.chomp
    unless sequence_repeated_back.split(" ") == seq
      @game_over = true
    end
  end

  def add_random_color
    seq << COLORS.sample
  end

  def round_success_message
    puts "You won this round!"
  end

  def game_over_message
    puts "You lose! :("
  end

  def reset_game
    @sequence_length = 1
    @game_over = false
    @seq = []
  end
end
