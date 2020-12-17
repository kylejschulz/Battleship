class PlayerMessages
  def start_message
    puts "=====Welcome to BATTLESHIP====="
    puts "Enter p to play. Enter q to quit."
  end

  def restart_message
    puts "=======Welcome back!======="
  end

  def human_cruiser_text
    puts "Computer player has placed their ships."
    puts "Enter the location for your Cruiser (3 consecutive spaces): Like this A1 B1 C1 "
  end

  def wrong_coordinate
    puts "That's not going to work, please try again..."
  end

  def human_submarine_text
    puts "Please enter your locations for the Submarine (2 consecutive spaces): Like this D1 D2 "
  end

  def computer_header
    puts"=============COMPUTER BOARD============="
  end

  def player_header
    puts "==============PLAYER BOARD=============="
  end

  def enter_coordinates
    puts "Enter your coordinate: "
  end

  def player_loss
    puts "Way to lose to a computer, on easy mode!"
  end

  def player_win
    puts "Congrats on beating a computer!"
  end

  def play_again
    puts "Play again? (y/n)? "
  end

  def thanks
    puts "Thanks for Playing!!"
  end

end
