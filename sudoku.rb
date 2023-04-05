class SudokuSolver

  BORDER = {
    0 => [0,1,2],
    1 => [0,1,2],
    2 => [0,1,2],
    3 => [3,4,5],
    4 => [3,4,5],
    5 => [3,4,5],
    6 => [6,7,8],
    7 => [6,7,8],
    8 => [6,7,8],
  }

  def initialize(board)
    @board = board
  end

  def solved?
    !@board.flatten.include?(0)
  end

  def find_solution
    while !solved?
      @board.each_with_index do |row, row_index|
        row.each_with_index do |value, column_index|
          if value.zero?
            row[column_index] = 1

            horizontal_numbers = row
            vertical_numbers = @board.map.with_index { |row, index| row[column_index] }
            box_numbers = box_number_by_index(row_index, column_index)
            all_numbers = (horizontal_numbers + vertical_numbers + box_numbers).reject(&:zero?).uniq
            possible_numbers = (1..9).to_a - all_numbers
            pretty_view
            if possible_numbers.size == 1
              @board[row_index][column_index] = possible_numbers.first
            end
          end
        end
      end
    end
    pretty_view
  end
  


  def box_number_by_index(row_index, column_index)
    row_indices = BORDER[row_index]
    column_indices = BORDER[column_index]

    values = []

    row_indices.each do |r_index|
      column_indices.each do |c_index|
        values << @board[c_index][r_index]
      end
    end

    values
  end

  def pretty_view
    @board.each_with_index do |row, row_index|
        print "#{row}\n"
    end
  end
end

board = [
  [0,0,0, 8,0,0, 0,3,0],
  [0,1,4, 0,0,5, 7,0,0],
  [3,0,9, 0,0,0, 5,6,0],
  [0,3,6, 7,8,0, 0,0,0],
  [1,0,0, 0,0,0, 4,0,0],
  [0,0,0, 0,1,3, 0,7,0],
  [0,0,0, 6,0,0, 0,4,9],
  [6,4,2, 0,3,9, 0,5,7],
  [7,0,3, 4,5,8, 0,2,1]
]

# board_1 = [
#   [1,1,1,1,1,1,1,1,1],
#   [1,1,1,1,1,1,1,1,1],
#   [1,1,1,1,1,1,1,1,1],
#   [1,1,1,1,1,1,1,1,1],
#   [1,1,1,1,1,1,1,1,1],
#   [1,1,1,1,1,1,1,1,1],
#   [1,1,1,1,1,1,1,1,1],
#   [1,1,1,1,1,1,1,1,1],
#   [1,1,1,1,1,1,1,1,1]
# ]

obj = SudokuSolver.new(board)
obj.find_solution
