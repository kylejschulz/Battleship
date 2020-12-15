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
    start_message
    start_up_conditional
  end

  def start_message
    puts "Welcome to BATTLESHIP
    Enter p to play. Enter q to quit."
  end

  def start_up_conditional
    player_choice = gets.chomp
    if player_choice == "q"
    p "See you next time"
      exit
    elsif player_choice == "p"
      set_up
    else player_choice
      start
    end
  end

  def game_setup
    computer_setup
    human_setup
  end

  def turn_setup
    until @game_over == true
      turn_start
      fire
      report_shot
      check_win
    end
  end

  def fire
    player_fire
    computer_fire
  end

  def report_shot
    report_player_shot
    report_computer_shot
  end

  def set_up
    game_setup
    turn_setup
  end


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


  def computer_setup
    @computer_board = Board.new
    if (computer_cruiser_placement(computer_cruiser_coordinates) & computer_submarine_placement(computer_submarine_coordinates)) == []
      # (computer_cruiser_placement(computer_cruiser_coordinates) && computer_submarine_placement(computer_submarine_coordinates))
      puts @computer_board.render(true)
      p "First I will set-up my ships"
    else
      computer_setup
    end
  end

  def human_setup
    human_cruiser_text
    human_cruiser_setup
    human_submarine_text
    human_submarine_setup
  end

  def human_cruiser_text
    p "Human, I have laid out my ships on the grid."
    p "You now need to lay out your two ships."
    puts "The Cruiser is three units long."
      "  1 2 3 4 \n" +
      "A . . . . \n" +
      "B . . . . \n" +
      "C . . . . \n" +
      "D . . . . \n"
  end

    def human_submarine_text
      puts "The Submarine is two units long."
        "  1 2 3 4 \n" +
        "A . . . . \n" +
        "B . . . . \n" +
        "C . . . . \n" +
        "D . . . . \n"
    end
    def human_board_render
      puts @human_board.render(true)
    end

  def human_cruiser_setup
    human_board_render
    p "Please enter your locations for the Cruiser (3 consecutive spaces): like this A1 B1 C1 "
    cruiser_coordinates = Array(gets.chomp.upcase.split(" "))
    if @human_board.valid_placement?(@human_cruiser, cruiser_coordinates)
      @human_board.place(@human_cruiser, cruiser_coordinates)
      human_board_render
    else
      p "That's not going to work, please try again"
      human_cruiser_setup
    end
  end

  def human_submarine_setup
    human_board_render
    p "Please enter your locations for the Submarine (2 consecutive spaces): like this D1 D2 "
    submarine_coordinates = Array(gets.chomp.upcase.split(" "))
      if @human_board.valid_placement?(@human_submarine, submarine_coordinates)
      @human_board.place(@human_submarine, submarine_coordinates)
      human_board_render
    else
      p "That's not going to work, please try again"
      human_submarine_setup
    end
  end

  def computer_cruiser_coordinates
    cruiser_placement = [["A1", "A2", "A3"],["B1", "B2", "B3"],["C1", "C2", "C3"],["D1", "D2", "D3"],
                        ["A2", "A3", "A4"],["B2", "B3", "B4"],["C2", "C3", "C4"],["D2", "D3", "D4"],
                        ["A1","B1","C1"], ["A2","B2","C2"], ["A3","B3","C3"], ["A4","B4","C4"],
                        ["B1","C1","D1"], ["B2","C2","D2"], ["B3","C3","D3"], ["B4","C4","D4"]]
    random_cruiser_coordinates = cruiser_placement.sample
    random_cruiser_coordinates
  end

  def computer_cruiser_placement(computer_cruiser_coordinates)
    @computer_board.place(@computer_cruiser, computer_cruiser_coordinates)
  end

  def computer_submarine_coordinates
    submarine_placement = [["A1", "A2"],["A2", "A3"],["A3", "A4"],
                    ["B1", "B2"],["B2", "B3"],["B3", "B4"],
                    ["C1", "C2"],["C2", "C3"],["C3", "C4"],
                    ["D1", "D2"],["D2", "D3"],["D3", "D4"],
                    ["A1", "B1"], ["B1", "C1"], ["C1", "D1"],
                    ["A2", "B2"], ["B2", "C2"], ["C2", "D2"],
                    ["A3", "B3"], ["B3", "C3"], ["C3", "D3"],
                    ["A4", "B4"], ["B4", "C4"], ["C4", "D4"]]
    random_submaine_coordinates = submarine_placement.sample
    random_submaine_coordinates
  end

    def computer_submarine_placement(computer_submarine_coordinates)
    @computer_board.place(@computer_submarine, computer_submarine_coordinates)
  end
end


def turn_start
  puts"=============COMPUTER BOARD============="
  puts @computer_board.render(true)

  puts "==============PLAYER BOARD=============="
  human_board_render
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
