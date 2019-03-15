require_relative "code"

class Mastermind
  def initialize(length)
    @secret_code = Code.new(Code.random(length).pegs)
  end

  def print_matches(code_instance)
    print "exact matches: "
    p @secret_code.num_exact_matches(code_instance)
    print "near matches: "
    p @secret_code.num_near_matches(code_instance)
  end

  def ask_user_for_guess
    print "Enter a code:"
    input = gets.chomp
    user_guess = Code.from_string(input)
    print_matches(user_guess)
    @secret_code == user_guess
  end
end
