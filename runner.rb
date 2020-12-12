require './lib/game'

  puts "Welcome to BATTLESHIP
  Enter p to play. Enter q to quit."

loop do
  player_choice = gets.chomp

  if player_choice == "q"
  "See you next time"
    break
  elsif player_choice == "p"
    game.start
  else player_choice != "q" || "p"
    puts "select again"
  end
end
