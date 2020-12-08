require './lib/ship'
class Cell
  attr_reader :coordinate, :ship
  def initialize(coordinate, ship = nil)
    @coordinate = coordinate
    @ship = ship
  end

  def empty?
    @ship == nil
  end

  def place_ship(ship)
    @ship = ship
  end

  def fired_upon?
    @health != @length
  end

  def fire_upon
  #  if fired_upon? #&& (@coordinate.empty? == false)
      ship.health -= 1

  end
end

#this is an addition
