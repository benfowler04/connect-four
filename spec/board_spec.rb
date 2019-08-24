require './lib/board'

RSpec.describe Board do
    describe "#initialize" do
        it "creates an empty board" do
            board = Board.new
            expect(board.current_state.uniq.length).to eql(1)
        end
        it "creates 7 columns" do
            board = Board.new
            expect(board.current_state.length).to eql(7)
        end
        it "creates 6 rows" do
            board = Board.new
            expect(board.current_state[0].length).to eql(6)
        end
    end

    describe "#is_move_valid?" do
        it "returns false if column is out of bounds" do
            board = Board.new
            expect(board.is_move_valid?(7)).to eql(false)
        end
        it "returns false if row is full" do
            board = Board.new
            3.times { board.drop_token(0, "B") }
            3.times { board.drop_token(0, "R") }
            expect(board.is_move_valid?(0)).to eql(false)
        end
        it "returns true if column is empty" do
            board = Board.new
            expect(board.is_move_valid?(0)).to eql(true)
        end
        it "returns true if column is neither empty nor full" do
            board = Board.new
            2.times { board.drop_token(0, "B") }
            expect(board.is_move_valid?(0)).to eql(true)
        end
    end

    describe "#drop_token" do
        it "returns 1 if this completes 4 in a column" do
            board = Board.new
            3.times { board.drop_token(0, "B") }
            expect(board.drop_token(0, "B")).to eql(1)
        end
        it "returns 1 if this completes 4 in a row" do
            board = Board.new
            board.drop_token(3, "B")
            board.drop_token(2, "B")
            board.drop_token(1, "B")
            expect(board.drop_token(0, "B")).to eql(1)
        end
        it "returns 1 if this completes 4 in a diagonal" do
            board = Board.new
            board.drop_token(0, "B")
            board.drop_token(1, "R")
            board.drop_token(1, "B")
            2.times { board.drop_token(2, "R") }
            3.times { board.drop_token(3, "R") }
            board.drop_token(3, "B")
            expect(board.drop_token(2, "B")).to eql(1)
        end
        it "returns 0 if the game should continue" do
            board = Board.new
            board.drop_token(0, "B")
            expect(board.drop_token(0, "R")).to eql(0)
        end
        it "returns -1 if the game ends in a draw" do
            board = Board.new
            3.times { board.drop_token(0, "B") }
            3.times { board.drop_token(0, "R") }
            3.times { board.drop_token(1, "R") }
            3.times { board.drop_token(1, "B") }
            3.times { board.drop_token(2, "B") }
            3.times { board.drop_token(2, "R") }
            3.times { board.drop_token(3, "R") }
            3.times { board.drop_token(3, "B") }
            3.times { board.drop_token(4, "B") }
            3.times { board.drop_token(4, "R") }
            3.times { board.drop_token(5, "R") }
            3.times { board.drop_token(5, "B") }
            3.times { board.drop_token(6, "B") }
            2.times { board.drop_token(6, "R") }
            expect(board.drop_token(6, "R")).to eql(-1)
        end
        it "updates the game board when a token is dropped into an empty column" do
            board = Board.new
            board.drop_token(0, "B")
            expect(board.current_state[0][0]).to eql("B")
        end
        it "updates the game board when a token is dropped into a non-empty column" do
            board = Board.new
            board.drop_token(0, "B")
            board.drop_token(0, "R")
            expect(board.current_state[0][1]).to eql("R")
        end
    end

    describe "#show_board" do
        it "outputs an empty board" do
            board = Board.new
            expect{board.show_board}.to output("ooooooo\nooooooo\nooooooo\nooooooo\nooooooo\nooooooo\n").to_stdout
        end
        it "outputs a board with tokens" do
            board = Board.new
            board.drop_token(0, "B")
            board.drop_token(0, "R")
            expect{board.show_board}.to output("ooooooo\nooooooo\nooooooo\nooooooo\nRoooooo\nBoooooo\n").to_stdout
        end
    end
end