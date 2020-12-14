1. fire_upon method in cell.rb prevent firing in same spot to sink ship
2. fire upon method more robust, check for valid input
3. In board test and board.render add new lines
4. refactor same letters and same numbers refactors in board.rb
5. examine necessity of required files in each file
6. Jacob's sick-ass symbols
7. Allow for accepting any case of alpha-numeric


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

## Functionality Checklist -

- Main Menu:

User is shown the main menu where they can play or quit

- Setup:

Computer can place ships randomly in valid locations
User can enter valid sequences to place both ships
Entering invalid ship placements prompts user to enter valid placements

- Turn:

User board is displayed showing hits, misses, sunken ships, and ships
Computer board is displayed showing hits, misses, and sunken ships
Computer chooses a random shot
Computer does not fire on the same spot twice
User can choose a valid coordinate to fire on
Entering invalid coordinate prompts user to enter valid coordinate
Both computer and player shots are reported as a hit, sink, or miss
User is informed when they have already fired on a coordinate
Board is updated after a turn

- End Game:

Game ends when all the user’s ships are sunk
Game ends when all the computer’s ships are sunk
Game reports who won
Game returns user back to the Main Menu
