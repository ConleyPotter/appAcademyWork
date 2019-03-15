require_relative "player"

class Game
    attr_reader :fragment

    def initialize(*players)
        @players = players
        @fragment = ""
        @dictionary = {}
        File.open("dictionary.txt").each do |line|
            @dictionary[line.chomp] = true
        end
        @losses = {}
        @players.each do |player|
            @losses[player] = 0
        end
    end

    def remaining_players
        remaining = @players.select { |player| @losses[player] < 5 }
        remaining.length
    end

    def play_round
        self.take_turn(self.current_player)
        self.next_player!
        if @dictionary.keys.include?(@fragment)
            @losses[self.previous_player] += 1
            # @players.reject! { |player| @losses[self.previous_player] == 5 }
            puts "#{@fragment} is a word"
            @fragment = ""
        end
    end

    def current_player
        @current_player ||= @players.first
    end

    def previous_player
        @previous_player ||= @players.last
    end

    def next_player!
        @previous_player, @current_player = @current_player, @players[(@players.find_index(@current_player) + 1) % @players.length]
        while @losses[@current_player] == 5
            @current_player = @players[(@players.find_index(@current_player) + 1) % @players.length]  
        end
    end

    def take_turn(player)
        valid_play = false
        while !valid_play
            print "#{player.name}, Input next letter: "
            if player.instance_of? AiPlayer
                player.fragment = @fragment
            end
            input = player.guess
            if valid_play?(input)
                valid_play = true
                @fragment += input
                puts "Current Fragment: " + self.fragment
            else
                player.alert_invalid_guess
            end
        end
    end

    def valid_play?(string)        
        if !("a".."z").include?(string)
            return false
        else
            guess = @fragment + string
            return @dictionary.keys.any? do |key|
                key[0, guess.length] == guess
            end
        end
    end

    def record(player)
        return "GHOST"[0, @losses[player]]
    end

    def run
        until @players.one? { |player| @losses[player] < 5 }
            @players.each do |player|
                if player.instance_of? AiPlayer
                    player.remaining_players = self.remaining_players
                end
            end
            self.play_round
            self.display_standings
        end
        winner = @losses.keys.select { |player| @losses[player] < 5 } 
        print winner[0].name + " wins!"
    end

    def display_standings
        puts "-----------------------"
        @players.each_with_index do |player, idx|
            puts "Player #{idx + 1}: " + self.record(player)
        end
    end
end
