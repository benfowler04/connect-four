require './lib/connect_four'

puts "Player 1, what's your name?"
player1 = gets.chomp
puts
puts "Player 2, what's your name?"
player2 = gets.chomp

game = ConnectFour.new(player1, player2)
game.play