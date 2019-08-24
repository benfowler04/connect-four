require './lib/players'

RSpec.describe Players do
    describe "#initialize" do
        it "sets the first player as the current player" do
            players = Players.new("Ben","Bob")
            expect(players.current_player).to eql("Ben")
        end
        it "sets the first player's token color to black" do
            players = Players.new("Ben", "Bob")
            expect(players.current_token).to eql("B")
        end
    end

    describe "#switch_player" do
        it "switches from player 1 to player 2" do
            players = Players.new("Ben","Bob")
            players.switch_player
            expect(players.current_player).to eql("Bob")
        end
        it "switches from player 2 to player 1" do
            players = Players.new("Ben","Bob")
            2.times { players.switch_player }
            expect(players.current_player).to eql("Ben")
        end
        it "switches the current token color to red" do
            players = Players.new("Ben", "Bob")
            players.switch_player
            expect(players.current_token).to eql("R")
        end
        it "switches the current token color to black" do
            players = Players.new("Ben","Bob")
            2.times { players.switch_player }
            expect(players.current_token).to eql("B")
        end
    end
end