require './lib/ship'

class Cell
  attr_reader :coordinate, :ship, :fired_upon
  def initialize(coordinate, ship = nil)
    @coordinate = coordinate
    @ship = ship
    @fired_upon = false
  end

  def empty?
    @ship == nil
  end

  def place_ship(vessel)
    @ship = vessel
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    if fired_upon?
      "already shot"
    elsif empty? == false
      ship.health -= 1
      @fired_upon = true
    else
      @fired_upon = true
    end
  end

  def render(arg = false)
    if @ship != nil && @ship.sunk?
      "X"
    elsif
      @fired_upon == true && empty? == false
      "H"
    elsif
      arg == true && @ship != nil
      "S"
    elsif
      @fired_upon == true && empty? == true
      "M"
    else
      empty? == true
      "."
    end
  end
end
