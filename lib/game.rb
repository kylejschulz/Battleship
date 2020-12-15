require './lib/board'
require './lib/cell'
require './lib/ship'

class Game

  def initialize
    @human_board = Board.new
    @human_cruiser = Ship.new("Cruiser", 3)
    @human_submarine = Ship.new("Submarine", 2)
    @computer_choice = nil
    @player_choice = nil
    @game_over = false
    @computer_board = Board.new
    @computer_cruiser = Ship.new("Cruiser", 3)
    @computer_submarine = Ship.new("Submarine", 2)
  end

  def start
    puts "Welcome to BATTLESHIP
    Enter p to play. Enter q to quit."

    player_choice = gets.chomp

    if player_choice == "q"
    p "See you next time"
      exit
    elsif player_choice == "p"
      set_up
      #start_round
    else player_choice
      start
    end
  end

  def game_setup
    computer_setup
    human_setup
  end

  def turn_setup
    # require "pry"; binding.pry
    until @game_over == true
      turn_start
      player_fire
      computer_fire
      report_player_shot
      report_computer_shot
      check_win
    end
  end

  def set_up
    game_setup
    turn_setup
  end

  def computer_setup
    p "First I will set-up my ships"
    # require "pry"; binding.pry
    if (computer_cruiser_placement & computer_sub_placement) == []
      p @computer_board.render(true)
    else
      computer_setup
    end
  end

  def human_setup
    p "Human, I have laid out my ships on the grid."
    p "You now need to lay out your two ships."
    puts "The Cruiser is three units long."
      "  1 2 3 4 \n" +
      "A . . . . \n" +
      "B . . . . \n" +
      "C . . . . \n" +
      "D . . . . \n"
    human_cruiser_setup
    puts "The Submarine is two units long."
      "  1 2 3 4 \n" +
      "A . . . . \n" +
      "B . . . . \n" +
      "C . . . . \n" +
      "D . . . . \n"
    human_submarine_setup
  end

  def human_cruiser_setup
    puts @human_board.render(true)
    p "Please enter your locations for the Cruiser (3 consecutive spaces): like this A1 B1 C1 "
    cruiser_coordinates = Array(gets.chomp.upcase.split(" "))
    if @human_board.valid_placement?(@human_cruiser, cruiser_coordinates)
      @human_board.place(@human_cruiser, cruiser_coordinates)
      puts @human_board.render(true)
    else
      p "That's not going to work, please try again"
      human_cruiser_setup
    end
  end

  def human_submarine_setup
    puts @human_board.render(true)
    p "Please enter your locations for the Submarine (2 consecutive spaces): like this D1 D2 "
    submarine_coordinates = Array(gets.chomp.upcase.split(" "))
      if @human_board.valid_placement?(@human_submarine, submarine_coordinates)
      @human_board.place(@human_submarine, submarine_coordinates)
      puts @human_board.render(true)
    else
      p "That's not going to work, please try again"
      human_submarine_setup
    end
  end

  def computer_cruiser_placement
    cruiser_placement = [["A1", "A2", "A3"],["B1", "B2", "B3"],["C1", "C2", "C3"],["D1", "D2", "D3"],
                        ["A2", "A3", "A4"],["B2", "B3", "B4"],["C2", "C3", "C4"],["D2", "D3", "D4"],
                        ["A1","B1","C1"], ["A2","B2","C2"], ["A3","B3","C3"], ["A4","B4","C4"],
                        ["B1","C1","D1"], ["B2","C2","D2"], ["B3","C3","D3"], ["B4","C4","D4"]]
    random_cruiser_coordinates = cruiser_placement.sample
    @computer_board.place(@computer_cruiser, random_cruiser_coordinates)
  end

  def computer_sub_placement
    submarine_placement = [["A1", "A2"],["A2", "A3"],["A3", "A4"],
                    ["B1", "B2"],["B2", "B3"],["B3", "B4"],
                    ["C1", "C2"],["C2", "C3"],["C3", "C4"],
                    ["D1", "D2"],["D2", "D3"],["D3", "D4"],
                    ["A1", "B1"], ["B1", "C1"], ["C1", "D1"],
                    ["A2", "B2"], ["B2", "C2"], ["C2", "D2"],
                    ["A3", "B3"], ["B3", "C3"], ["C3", "D3"],
                    ["A4", "B4"], ["B4", "C4"], ["C4", "D4"]]
    random_submarine_coordinates = submarine_placement.sample
    @computer_board.place(@computer_submarine, random_submarine_coordinates)
  end
end


def turn_start
  puts"=============COMPUTER BOARD============="
  puts @computer_board.render(true)

  puts "==============PLAYER BOARD=============="
  puts @human_board.render(true)
end

def player_fire
  puts "Pick your coordinates to fire on: "

  valid_shot = false
  until valid_shot
    player_choice = gets.chomp.upcase
    if !@human_board.valid_coordinate?(player_choice)
      puts "#{player_choice} doesn't work\n"+
            "Please select a valid coordinate: "
    elsif @computer_board.cells[player_choice].fire_upon == "already shot"
      puts "Already fired on. Choose a valid coordinate"

    else
      valid_shot = true
    end
  end

  @computer_board.cells[player_choice].fire_upon
  @player_choice = player_choice
end

def computer_fire
  shots = @human_board.cells.keys
  computer_choice = shots.sample
  valid_shot = false

  until valid_shot
    if @human_board.cells[computer_choice].fire_upon == "already shot"
      computer_choice = shots.sample
    else
      valid_shot = true
    end
  end

  @human_board.cells[computer_choice].fire_upon
  @computer_choice = computer_choice
end

def report_player_shot
  cell = @computer_board.cells[@player_choice]

  if !cell.empty? && cell.ship.sunk?
    puts "You sunk the computer's #{cell.ship.name}!"
  elsif cell.empty?
    puts "Your shot on #{@player_choice} missed!"
  elsif !cell.empty?
    puts "You hit the computer's #{cell.ship.name}!"
  end
end

def report_computer_shot
  cell = @human_board.cells[@computer_choice]

  if !cell.empty? && cell.ship.sunk?
    puts "The computer sunk your#{cell.ship.name}"
  elsif cell.empty?
    puts "The computer's shot on #{@computer_choice} missed!"
  elsif !cell.empty?
    puts "THe computer hit your #{cell.ship.name}!"
  end
end

def check_win
  if (@computer_cruiser.sunk? && @computer_submarine.sunk?) && (@human_cruiser.sunk? && @human_submarine.sunk?)
    puts "Draw!!"
    @game_over = true
  elsif @human_cruiser.sunk? && @human_submarine.sunk?
    puts "way to lose to a computer"
    @game_over = true
  elsif @computer_submarine.sunk? && @computer_cruiser.sunk?
    puts "congrats on beating a computer"
    @game_over = true
  end
end


# def set_up
# p "hello"
#   computer_ship_placement
# #   player_ship_placement
# #   # Need computer board, need player board
# #   # Computer ship placement, player ship placement
# end
# #

# def random_coordinate_array_generator
  # random_coordinate = @computer_board.cells.keys.shuffle
  #
  # start_array = ['3', '4', 'C', 'D']
  # p random_coordinate unless random_coordinate.!include?(start_array)
  # if random_coordinate.include? start_array
  #   p "#{random_coordinate.length} contains '34CD'"
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
# end

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
