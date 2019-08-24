require './lib/board'
require './lib/players'

class ConnectFour
    def initialize(player1, player2)
        @players = Players.new(player1, player2)
        @board = Board.new
    end

    def play
        game_over = false
        until game_over
            valid_move = false
            until valid_move
                puts
                @board.show_board
                puts
                puts "It's #{@players.current_player}'s turn. Select a column (1-7 starting from left)"
                column = gets.chomp.to_i
                valid_move = true if @board.is_move_valid?(column - 1)
            end
            result = @board.drop_token(column - 1, @players.current_token)
            if result == -1
                puts
                @board.show_board
                puts
                puts "It's a draw."
                game_over = true
            elsif result == 1
                puts
                @board.show_board
                puts
                puts "#{@players.current_player} wins!"
                game_over = true
            else
                @players.switch_player
            end
        end
    end
end