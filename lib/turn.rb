require './lib/board'

class Turn
  def computer_setup
    computer_ship_setup(@computer_cruiser, 3)
    computer_ship_setup(@computer_submarine, 2)
  end
end
