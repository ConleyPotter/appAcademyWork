class AiPlayer
    attr_reader :name

    def initialize
        @name = "AiPlayer"
        @dictionary = {}
        File.open("dictionary.txt").each do |line|
            @dictionary[line.chomp] = true
        end
    end

    def remaining_players=(remaining)
        @remaining_players = remaining
    end

    def fragment=(fragment)
        @fragment = fragment
    end

    def guess

        ("a".."z").to_a.each_with_index do |letter, idx|
            if @dictionary.include?(@fragment + letter)
                guess = letter
            end
        end
        guess = "a"
        return guess
    end
end