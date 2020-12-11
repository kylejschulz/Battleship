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
    a = @cells.keys
    b = [coordinate].flatten

    if (b & a) == b
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
    bools = []
    coordinates.each do |coordinate|
      bools << @cells[coordinate].empty?
    end
    bools.include?(false)
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

  def same_numbers#(ship_length)
    same_num = [[1,1], [2,2], [3,3], [4,4], [1,1,1],[2,2,2],[3,3,3],[4,4,4]]

    # (1..4).to_a.each do |num|
    #   same_num << (num.to_s * ship_length)
    #   end
    #
    # number_array = []
    # same_num.each do |string|
    #
    #   number_array << string.split('')
    # end
     same_num.include?@numbers #number_array
  end



  def same_letters#(ship_length)
    same_let = [['A', 'A'], ['B', 'B'], ['C', 'C'], ['D', 'D'], ['A', 'A','A'], ['B', 'B', 'B'], ['C', 'C', 'C'], ['D', 'D', 'D']]

    # ('A'..'D').to_a.each do |letter|
    #   same_let << (letter * ship_length)
    # end
    # letter_array = []
    # same_let.each do |string|
    #   letter_array << string.split('')
    # end
    same_let.include?@letters #letter_array
  end

  def place(ship, coordinates)
    coordinates.each do |coordinate|
      @cells[coordinate].place_ship(ship)
    end
  end

  def render(arg = false)
    # "  1 2 3 4 \n" +
    # "A #{@cells["A1"].render} . . . \n" +
    # "B . . . . \n" +
    # "C . . . . \n" +
    # "D . . . . \n"

    cell_array = []

    @cells.each do |coordinate, cell|
      # require "pry"; binding.pry
      cell_array << cell.render(arg)
    end
    p cell_array
  end

end
