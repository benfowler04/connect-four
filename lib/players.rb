class Players
    attr_reader :current_player, :current_token

    def initialize(player1, player2)
        @player1 = player1
        @player2 = player2
        @current_player = @player1
        @current_token = "B"
    end

    def switch_player
        if @current_player == @player1
            @current_player = @player2
            @current_token = "R"
        else
            @current_player = @player1
            @current_token = "B"
        end
    end
end