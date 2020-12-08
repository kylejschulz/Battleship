require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'


class CellTest < Minitest::Test
  def setup
    @cell = Cell.new("B4")
    @cruiser = Ship.new("Cruiser", 3)
  end
  def test_it_exists_and_has_attributes
    assert_instance_of Cell, @cell
    assert_equal "B4", @cell.coordinate
  end

  def test_it_has_ship
    assert_nil @cell.ship
  end

  def test_it_can_be_empty
    assert_equal true, @cell.empty?
  end

  def test_cell_can_place_cruiser
    @cell.place_ship(@cruiser)

    assert_equal @cruiser, @cell.ship
    assert_equal false, @cell.empty?
  end

  def test_cell_can_be_fired_upon
    @cell.place_ship(@cruiser)

    assert_equal false, @cell.fired_upon?

    @cell.fire_upon

    assert_equal 2, @cell.ship.health# => 2
    require "pry"; binding.pry
    assert_equal true, @cell.fired_upon?# => true
  end
end
