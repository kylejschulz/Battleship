require './board'
require './cell'
require './ship'

class Game

  def initialize
    @computer_board = Board.new
    @computer_cruiser = Ship.new("Cruiser", 3)
    @computer_submarine = Ship.new("Submarine", 2)
  end

  # def start
  #   set_up
  # end
  #
  # def set_up
  #   computer_ship_placement
  #   player_ship_placement
  #   # Need computer board, need player board
  #   # Computer ship placement, player ship placement
  # end
  #
  def computer_ship_placement
    cruiser_placement = [["A1", "A2", "A3"],["B1", "B2", "B3"],["C1", "C2", "C3"],["D1", "D2", "D3"],
                        ["A2", "A3", "A4"],["B2", "B3", "B4"],["C2", "C3", "C4"],["D2", "D3", "D4"],
                        ["A1","B1","C1"], ["A2","B2","C2"], ["A3","B3","C3"], ["A4","B4","C4"],
                        ["B1","C1","D1"], ["B2","C2","D2"], ["B3","C3","D3"], ["B4","C4","D4"]]
    sub_placement = []
    rand = rand(0..15)
    starting_point = cruiser_placement[rand]

    # computer_board.place(computer_submarine, random_coordinate)
    @computer_board.place(@computer_cruiser, starting_point)

  end

  def random_coordinate_array_generator
    # random_coordinate = @computer_board.cells.keys.shuffle
    #
    # start_array = ['3', '4', 'C', 'D']
    # p random_coordinate unless random_coordinate.!include?(start_array)
    # if random_coordinate.include? start_array
    #   puts "#{random_coordinate.length} contains '34CD'"
    # else
    #   puts "#{random_coordinate} doesn't contain '34CD'"
    # end
    # !random_coordinate.include?("4") ||
    # !random_coordinate.include?("C") ||
    # !random_coordinate.include?("D")

    # if random_coordinate for cruiser does not include
    #   c,d, 3 or 4 then it is a valid coordinate
    # then we will take the random_coordinate and
    # either choose a coordinate down or right
    # then the final coordinate will be adjacent to
    # second coordinate
  end




  # def player_ship_placement
  #   puts "I have laid out my ships on the grid.
  # You now need to lay out your two ships.
  # The Cruiser is three units long and the Submarine is two units long.
  #   1 2 3 4
  # A . . . .
  # B . . . .
  # C . . . .
  # D . . . .
  # Enter the squares for the Cruiser (3 spaces):"
  # end
  #
  # def turn
  #   #board.render?
  #   #Player choosing a coordinate to fire on
  #   #Computer choosing a coordinate to fire on
  #   #Reporting the result of the Player’s shot
  #   #Reporting the result of the Computer’s shot
  # end
end


game = Game.new
game.computer_ship_placement
