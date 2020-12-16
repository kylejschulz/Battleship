require './lib/board'

class Game

  def initialize
    @human_board = Board.new
    @human_cruiser = Ship.new("Cruiser", 3)
    @human_submarine = Ship.new("Submarine", 2)
    @turn = 'player'
    @player_shot = nil
    @computer_shot = nil
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
    puts "See you next time"
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
    turn_start
    until @game_over == true
      fire
      report_shot
      check_win
      switch_players
      turn_start
    end
    play_again
  end

  def set_up
    game_setup
    turn_setup
  end

  def computer_setup
    cruiser = random_cruiser_coordinates
    sub = random_submarine_coordinates
    if (cruiser & sub) == []
      computer_cruiser_placement(cruiser)
      computer_sub_placement(sub)
    else
      computer_setup
    end
  end

  def human_setup
    human_cruiser_setup
    human_submarine_setup
  end

  def human_cruiser_setup
    puts @human_board.render(true)
    human_cruiser_text
    cruiser_coordinates = Array(gets.chomp.upcase.split(" "))
    if @human_board.valid_placement?(@human_cruiser, cruiser_coordinates)
      @human_board.place(@human_cruiser, cruiser_coordinates)
    else
      puts "That's not going to work, please try again"
      human_cruiser_setup
    end
  end

  def human_cruiser_text
    puts "Computer player has placed their ships."
    puts "Enter the location for your Cruiser (3 consecutive spaces): like this A1 B1 C1 "
  end

  def human_submarine_setup
    puts @human_board.render(true)
    human_submarine_text
    submarine_coordinates = Array(gets.chomp.upcase.split(" "))
      if @human_board.valid_placement?(@human_submarine, submarine_coordinates)
      @human_board.place(@human_submarine, submarine_coordinates)
      puts @human_board.render(true)
    else
      puts "That's not going to work, please try again"
      human_submarine_setup
    end
  end

  def human_submarine_text
    puts "Please enter your locations for the Submarine (2 consecutive spaces): like this D1 D2 "
  end

  def random_cruiser_coordinates
    cruiser_placement = [["A1", "A2", "A3"],["B1", "B2", "B3"],["C1", "C2", "C3"],["D1", "D2", "D3"],
                        ["A2", "A3", "A4"],["B2", "B3", "B4"],["C2", "C3", "C4"],["D2", "D3", "D4"],
                        ["A1","B1","C1"], ["A2","B2","C2"], ["A3","B3","C3"], ["A4","B4","C4"],
                        ["B1","C1","D1"], ["B2","C2","D2"], ["B3","C3","D3"], ["B4","C4","D4"]]
    random_cruiser_coordinates = cruiser_placement.sample
  end

  def computer_cruiser_placement(random_cruiser_coordinates)
    @computer_board.place(@computer_cruiser, random_cruiser_coordinates)
  end

  def random_submarine_coordinates
    submarine_placement = [["A1", "A2"],["A2", "A3"],["A3", "A4"],
                    ["B1", "B2"],["B2", "B3"],["B3", "B4"],
                    ["C1", "C2"],["C2", "C3"],["C3", "C4"],
                    ["D1", "D2"],["D2", "D3"],["D3", "D4"],
                    ["A1", "B1"], ["B1", "C1"], ["C1", "D1"],
                    ["A2", "B2"], ["B2", "C2"], ["C2", "D2"],
                    ["A3", "B3"], ["B3", "C3"], ["C3", "D3"],
                    ["A4", "B4"], ["B4", "C4"], ["C4", "D4"]]
    random_submarine_coordinates = submarine_placement.sample
  end

  def computer_sub_placement(random_submarine_coordinates)
    @computer_board.place(@computer_submarine, random_submarine_coordinates)
  end

  def turn_start
    if @turn == 'player'
      puts"=============COMPUTER BOARD============="
      puts @computer_board.render
      puts "==============PLAYER BOARD=============="
      puts @human_board.render(true)
    end
  end

  def player_fired_on
    puts "enter your coordinate: "
    @player_shot = gets.strip.upcase
  end

  def computer_choice
    shots = @human_board.cells.keys
    @computer_shot = shots.sample
  end

  def valid_shot(coordinate)
    if @turn == "player"
      if !@computer_board.valid_coordinate?(coordinate)
        puts "#{coordinate} Not valid"
        false
      elsif @computer_board.cells[coordinate].fire_upon == "already shot"
        puts "#{coordinate} already shot"
        false
      else
        true
      end
    else
      if @human_board.cells[coordinate].fire_upon == "already shot"
        false
      else
        true
      end
    end
  end

  def fire
    if @turn == 'player'
      player_fired_on
      until valid_shot(@player_shot)
        player_fired_on
      end
      @computer_board.cells[@player_shot].fire_upon
    else
      computer_choice
      until valid_shot(@computer_shot)
        computer_choice
      end
      @human_board.cells[@computer_shot].fire_upon
    end
  end

  def report_shot
    if @turn == 'player'
      cell = @computer_board.cells[@player_shot]
      player = "player"
    else
      cell = @human_board.cells[@computer_shot]
      player = "computer"
    end
    if !cell.empty? && cell.ship.sunk?
      puts "#{player} sunk the computer's #{cell.ship.name}!"
    elsif cell.empty?
      puts "#{player} shot on #{cell.coordinate} missed!"
    elsif !cell.empty?
      puts "#{player} hit the computer's #{cell.ship.name}!"
    end
  end

  def check_win
    if @human_cruiser.sunk? && @human_submarine.sunk?
      puts "way to lose to a computer"
      @game_over = true
    elsif @computer_submarine.sunk? && @computer_cruiser.sunk?
      puts "congrats on beating a computer"
      @game_over = true
    end
  end

  def switch_players
    if @turn == "player"
      @turn = "computer"
    else
      @turn = "player"
    end
  end

  def play_again
    puts "play again? (y/n)? "
    answer = gets.chomp.upcase
    if answer == 'Y' || answer == 'YES'
      Game.new.start
    else
      puts "Thanks for Playing!!"
    end
  end
end
