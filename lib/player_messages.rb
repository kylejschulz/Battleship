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
    puts "Enter the location for your Cruiser (3 consecutive spaces): like this A1 B1 C1 "
  end

  def wrong_coordinate
    puts "That's not going to work, please try again"
  end

  def human_submarine_text
    puts "Please enter your locations for the Submarine (2 consecutive spaces): like this D1 D2 "
  end

  def computer_header
    puts"=============COMPUTER BOARD============="
  end

  def player_header
    puts "==============PLAYER BOARD=============="
  end

  def enter_coordinates
    puts "enter your coordinate: "
  end

  def player_loss
    puts "way to lose to a computer"
  end

  def player_win
    puts "congrats on beating a computer"
  end

  def play_again
    puts "play again? (y/n)? "
  end

  def thanks
    puts "Thanks for Playing!!"
  end

end
