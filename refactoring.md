1. write tests for game class
2. refactor same letters and same numbers refactors in board.rb
3. Jacob's sick-ass symbols


## Iteration 3
1. runner.rb class, to run from terminal. Only functionality, should be calling on game class, where the rest of the game should call it's functionality from.

2. game_text.rb class, this is where we can refactor all
all text prompts to.

  - main_menu, etc

3. game.rb class, for all game functionality

  - setup -> computer ship placement -> player ship placement

4. turn_class.rb, game.rb will call on turn.rb for turn functionality.

- Displaying the boards
- Player choosing a coordinate to fire on
- Computer choosing a coordinate to fire on
- Reporting the result of the Player’s shot
- Reporting the result of the Computer’s shot

5. ruby runner.rb -> game.rb will begin game and call on all
other classes, to produce game interaction and text.

# def computer_setup
#   if (computer_cruiser_coordinates & computer_submarine_coordinates) == []
#     computer_cruiser_placement(computer_cruiser_coordinates)
#     computer_submarine_placement(computer_submarine_coordinates)
#     puts @computer_board.render(true)
#     p "First I will set-up my ships"
#   else
#     computer_setup
#   end
# end
