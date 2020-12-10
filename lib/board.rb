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

  def valid_placement?(ship, coordinates)
    ship.length == coordinates.length && valid_coordinate?(coordinates)
  end

  # def consecutive_letters
  #   # a = ""A"".ord
  #   # d = "D".ord
  #   # test = []
  #   #
  #   # (a..d).each_cons(4) do |letters|
  #   #   letters.each do |letter|
  #   #     test << letter.chr
  #   #   end
  #   # end
  #   # test
  # end
  #
  # def consecutive_numbers(ship_length)
  #   # test = []
  #   # (1..4).each_cons(ship_length) do |numbers|
  #   #     test << numbers
  #   # end
  #   # test.flatten.uniq
  #
  # end
  #
  #
  # def same_number
  #
  # end
  #
  #
  # def same_letter
  #
  # end

    def coordinate_breakdown(coordinates)
      @numbers = []
      @letters = []
      coordinates.each do |coordinate|
        letters << coordinate[0]
        numbers << coordinate[1].to_1
      end


    end

    def valid_placement?(ship, coordinates)
      coordinate_breakdown(coordinates)
      if consecutive_letters && same_numbers
        true
      elsif
        same_letters && consecutive_numbers
        true
      else
        false
      end
    end

    def consecutive_letters
      consecutive_letters = [["A", "B", "C"], ["B", "C", "D"]]
      consecutive_letters.include?@letters
    end

    def consecutive_numbers
      consecutive_numbers = [[1, 2, 3], [2, 3, 4]]
      consecutive_numbers.include?@numbers
    end

    def same_numbers
      same_numbers = [[1, 1, 1], [2, 2, 2], [3,3,3], [4,4,4]]
      same_numbers.include?@numbers
    end

    def same_letters
      same_letters = [["A", "A", "A"], ["B", "B", "B"], ["C","C","C"], ["D", "D", "D"]]
      same_letters.include?@letters
    end
    
end
