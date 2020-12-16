require './lib/cell'

class Board
  attr_reader :cells
  def initialize
    @cells =
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

  def valid_coordinate?(coordinate)
    if (([coordinate].flatten) & (@cells.keys)) == ([coordinate].flatten)
      true
    else
      false
    end
  end

  def coordinate_breakdown(coordinates)
    @numbers = []
    @letters = []
    coordinates.each do |coordinate|
      @letters << coordinate[0]
      @numbers << coordinate[1].to_i
    end
  end

  def check_overlap(coordinates)
    booleans = []
    coordinates.each do |coordinate|
      if @cells[coordinate] == nil
        booleans << false
      else
        booleans << @cells[coordinate].empty?
      end
    end
    booleans.include?(false)
  end

  def valid_placement?(ship, coordinates)
    coordinate_breakdown(coordinates)
    if check_overlap(coordinates)
      false
    elsif
      (consecutive_letters(ship.length) && same_numbers) && (ship.length == coordinates.count)
      true
    elsif
      (same_letters && consecutive_numbers(ship.length)) && (ship.length == coordinates.count)
      true
    else
      false
    end
  end

  def consecutive_letters(ship_length)
    consecutive_letters = []
    ('A'..'D').each_cons(ship_length) do |letters|
      consecutive_letters << letters
    end
    consecutive_letters.include?@letters
  end

  def consecutive_numbers(ship_length)
    consecutive_numbers = []
    (1..4).each_cons(ship_length) do |number|
      consecutive_numbers << number
    end
    consecutive_numbers.include?@numbers
  end

  def same_numbers
    same_num = [[1,1], [2,2], [3,3], [4,4], [1,1,1],[2,2,2],[3,3,3],[4,4,4]]
    same_num.include?@numbers
  end

  def same_letters
    same_let = [['A', 'A'], ['B', 'B'], ['C', 'C'], ['D', 'D'], ['A', 'A','A'], ['B', 'B', 'B'], ['C', 'C', 'C'], ['D', 'D', 'D']]
    same_let.include?@letters
  end

  def place(ship, coordinates)
    coordinates.each do |coordinate|
      @cells[coordinate].place_ship(ship)
    end
  end

  def create_row(range, show_ships = false)
  row = @cells.values.slice(range).map do |cell_object|
      cell_object.render(show_ships)
    end
    row.join(" ")
  end

  def render(show_ships = false)
    row1 = create_row(0..3, show_ships)
    row2 = create_row(4..7, show_ships)
    row3 = create_row(8..11, show_ships)
    row4 = create_row(12..15, show_ships)
    "  1 2 3 4 \n" +
    "A #{row1}\n" +
    "B #{row2}\n" +
    "C #{row3}\n" +
    "D #{row4}\n"
  end
end
