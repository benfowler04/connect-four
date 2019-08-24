class Board
    attr_reader :current_state
    
    def initialize
        @moves = 0
        @current_state = Array.new(7){Array.new(6)}
        for column in 0..6
            for row in 0..5
                @current_state[column][row] = "o"
            end
        end
    end

    def is_move_valid?(column)
        return false if column < 0 || column > 6
        return false unless @current_state[column][5] == "o"
        return true
    end

    def drop_token(column, color)
        row = @current_state[column].index("o")
        @current_state[column][row] = color
        @moves += 1
        return 1 if winning_move?(column, row)
        return -1 if draw?
        return 0
    end

    def show_board
        for row in [5,4,3,2,1,0]
            for column in 0..6
                print @current_state[column][row]
            end
            print "\n"
        end
    end

    private
    def draw?
        @moves == 42
    end

    def winning_move?(column, row)
        winning_column?(column) || winning_row?(row) || winning_diagonal?
    end

    def winning_column?(column)
        return false if @current_state[column].count("o") > 2
        possible_wins = []
        possible_wins.push(@current_state[column][0..3].uniq.length)
        possible_wins.push(@current_state[column][1..4].uniq.length)
        possible_wins.push(@current_state[column][2..5].uniq.length)
        return true if possible_wins.include?(1)
        return false
    end

    def winning_row?(row)
        row_contents = []
        for column in 0..6
            row_contents.push(@current_state[column][row])
        end
        return false if row_contents.count("o") > 3
        possible_wins = []
        possible_wins.push(row_contents[0..3].uniq.length)
        possible_wins.push(row_contents[1..4].uniq.length)
        possible_wins.push(row_contents[2..5].uniq.length)
        possible_wins.push(row_contents[3..6].uniq.length)
        return true if possible_wins.include?(1)
        return false
    end

    def winning_diagonal?
        possible_wins = []
        for column in 0..3
            for row in 0..2
                diagonal_contents = [@current_state[column][row]]
                diagonal_contents.push(@current_state[column + 1][row + 1])
                diagonal_contents.push(@current_state[column + 2][row + 2])
                diagonal_contents.push(@current_state[column + 3][row + 3])
                possible_wins.push(diagonal_contents.uniq.length) unless diagonal_contents.count("o") > 3
            end
            for row in 3..5
                diagonal_contents = [@current_state[column][row]]
                diagonal_contents.push(@current_state[column + 1][row - 1])
                diagonal_contents.push(@current_state[column + 2][row - 2])
                diagonal_contents.push(@current_state[column + 3][row - 3])
                possible_wins.push(diagonal_contents.uniq.length) unless diagonal_contents.count("o") > 3
            end
        end
        return true if possible_wins.include?(1)
        return false
    end
end