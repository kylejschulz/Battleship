require 'minitest/autorun'
require 'minitest/pride'
require './lib/game'
require './lib/cell'
require './lib/ship'
require './lib/board'


class GameTest < Minitest::Test
  def setup
    @game = Game.new
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

  def test_it_exists
    assert_instance_of Game, @game
  end

  def test_it_has_attributes
    assert_equal Board, @game.human_board
    assert_equal Ship.new("Cruiser", 3), @game.human_cruiser
    assert_equal Ship.new("Submarine", 2), @game.human_submarine
    assert_equal nil, @game.computer_choice
    assert_equal nil, @game.player_choice
    assert_equal false, @game.game_over
    assert_equal Board.new, @game.computer_board
    assert_equal Ship.new("Cruiser", 3), @game.computer_cruiser
    assert_equal Ship.new("Submarine", 2), @game.computer_submarine
  end

  def test_it_can_have_different_attributes
    skip
  end
end
