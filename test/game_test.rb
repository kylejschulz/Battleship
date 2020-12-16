require 'minitest/autorun'
require 'minitest/pride'
require './lib/game'
require './lib/cell'
require './lib/ship'
require './lib/board'


class GameTest < Minitest::Test
  def setup
    @game = mock
    @human_board = mock
    @human_cruiser = mock
    @human_submarine = mock
    @computer_choice = mock
    @player_choice = mock
    @game_over = mock
    @computer_board = mock
    @computer_cruiser = mock
    @computer_submarine = mock
  end

  def test_it_exists

  end

  def test_it_has_attributes

  end

  def test_it_can_have_different_attributes
    skip
  end
end
