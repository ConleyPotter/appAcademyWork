class Player
    attr_accessor :name

    def initialize(name)
        @name = name
    end

    def guess
        input = gets.chomp
        input
    end

    def alert_invalid_guess
        puts "invalid fragment"
    end
end