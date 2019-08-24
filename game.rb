require './lib/connect_four'

puts "Player 1, what's your name?"
player1 = gets.chomp
puts "You will use black tokens, denoted by a B on the game board."
puts
puts "Player 2, what's your name?"
player2 = gets.chomp
puts "You will use red tokens, denoted by an R on the game board."

game = ConnectFour.new(player1, player2)
game.play