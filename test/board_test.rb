require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
class BoardTest < Minitest::Test
  def setup
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
    @board_cells =
    {
      "A1" => Cell.new("A1"),
      "A2" => Cell.new("A2"),
      "A3" => Cell.new("A3"),
      "A4" => Cell.new("A4"),
      "B1" => Cell.new("B1"),
      "B2" => Cell.new("B2"),
      "B3" => Cell.new("B3"),
      "B4" => Cell.new("B4"),
      "C1" => Cell.new("C1"),
      "C2" => Cell.new("C2"),
      "C3" => Cell.new("C3"),
      "C4" => Cell.new("C4"),
      "D1" => Cell.new("D1"),
      "D2" => Cell.new("D2"),
      "D3" => Cell.new("D3"),
      "D4" => Cell.new("D4"),
    }
  end

  def test_it_exists_and_has_attributes
    assert_instance_of Board, @board
    assert_equal @board_cells.keys, @board.cells.keys
  end

  def test_for_valid_coordinates
    assert_equal true, @board.valid_coordinate?("A1")
    assert_equal true, @board.valid_coordinate?("D4")
    assert_equal false, @board.valid_coordinate?("A5")
    assert_equal false, @board.valid_coordinate?("E1")
    assert_equal false, @board.valid_coordinate?("A22")
  end

  def test_valid_placement
    assert_equal false, @board.valid_placement?(@cruiser, ["A1", "A2"])
    assert_equal false, @board.valid_placement?(@submarine, ["A2", "A3", "A4"])
  end

  def test_consecutive
    assert_equal false, @board.valid_placement?(@cruiser, ["A1", "A2", "A4"])
    assert_equal false, @board.valid_placement?(@submarine, ["A1", "C1"])
    assert_equal false, @board.valid_placement?(@cruiser, ["A3", "A2", "A1"])
    assert_equal false, @board.valid_placement?(@submarine, ["C1", "B1"])
  end

  def test_diagonals
    assert_equal false, @board.valid_placement?(@cruiser, ["A1", "B2", "C3"])
    assert_equal false, @board.valid_placement?(@submarine, ["C2", "D3"])
  end

  def test_valid_placement_is_true
    assert_equal true, @board.valid_placement?(@cruiser, ["B1", "C1", "D1"])
    assert_equal true, @board.valid_placement?(@submarine, ["A1", "A2"])
  end

  def test_it_can_place_ship
    @board.place(@cruiser, ["A1", "A2", "A3"])

    cell_1 = @board.cells["A1"]
    cell_2 = @board.cells["A2"]
    cell_3 = @board.cells["A3"]

    assert_equal @cruiser, cell_1.ship
    assert_equal @cruiser, cell_2.ship
    assert_equal @cruiser, cell_3.ship
    assert_equal true, cell_3.ship == cell_2.ship
  end

  def test_overlapping_ships
    @board.place(@cruiser, ["A1", "A2", "A3"])

    assert_equal false, @board.valid_placement?(@submarine, ["A1", "B1"])
  end

  def test_board_render
    expected1 = " 1 2 3 4 A . . . . B . . . . C . . . . D . . . . "
    expected2 = " 1 2 3 4 " + "A S S S . " + "B . . . . " + "C . . . . " + "D . . . . "
    expected3 = " 1 2 3 4 " + "A H . . . " + "B . . . M " + "C X . . . " + "D X . . . "
    expected4 = " 1 2 3 4 " + "A H S S . " + "B . . . M " + "C X . . . " + "D X . . . "

    assert_equal expected1, @board.render

    @board.place(@cruiser, ["A1", "A2", "A3"])

    assert_equal expected2, @board.render(true)

    @board.place(@submarine, ["C1", "D1"])

    @board.cells["A1"].fire_upon
    @board.cells["B4"].fire_upon
    @board.cells["C1"].fire_upon
    @board.cells["D1"].fire_upon

    assert_equal expected3, @board.render
    assert_equal expected4, @board.render(true)
  end
end
