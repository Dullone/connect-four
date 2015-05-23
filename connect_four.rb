class Connect
  attr_reader :board
  PLAYER_ONE = "X"
  def initialize(board, output = STDOUT, input = STDIN)
    @board = board
    @output = output
    @input = input
    @player_turn = PLAYER_ONE
  end

  def game_start
    show_board
    get_move
  end

  def show_board
    @output.puts @board.to_s
  end

  def get_move
    @output.puts "Player one, enter column (0-6) to add peice: "
    #make_move Connect_view.move_input @input
  end

  def player_won
    if token = row_has_win 
      return token
    end
    if token = column_has_win
      return token
    end
    if token = diagonal_has_win
      return token
    end
    false
  end

  def board_full?
    board.positions.each do |column|
      if column.all? { |item| item != Board::EMPTY }
        return true
      end
    end
    false
  end

  private
  def row_has_win
    board.rows.times do |row|
      if token = array_has_win(board.positions[row])
        return token
      end
    end
    false
  end

  def column_has_win
    column_array = []
    board.columns.times do |column|
      board.rows.times do |row|      
        column_array << board.positions[row][column]
      end
      if token = array_has_win(column_array)
        return token
      end
      column_array = []
    end
    false
  end

  def diagonal_has_win
    3.times do |i|
      #bottom-left to upper-right
      token = []
      token << (array_has_win get_array(i, 0, board.rows - 1, board.columns - 2 - i))      
      token << (array_has_win get_array(0, i, board.rows - i, board.columns - 1))
      #top-right to bottom-left
      token << (array_has_win get_array(i, board.columns - 1,     board.rows - 1,     i + 1))
      token << (array_has_win get_array(0, board.columns - 1 - i, board.rows - 2 - i, 0    ))
      token.each do |t|
        if t
          return t
        end
      end
    end
    false
  end

  def get_array(start_row, start_column, end_row, end_column)
    size = (start_row-end_row).abs
    array = []
    size.times do |i|
      array << board.positions[start_row + i][start_column + i]
    end

    array
  end

  #returns token type of winner
  def array_has_win(array)
    count = 0
    (array.length - 1).times do |i|
      if array[i] == array[i + 1] && array[i] != Board::EMPTY
        count += 1
      else
        count = 0
      end
      if count == 3
        return array[i]
      end
    end
    false
  end

  def make_move(slot)

  end
end

class Connect_view
  def Connect_view.move_input(input)
    input.gets.chomp
  end
end

class Board
  attr_reader :positions, :rows, :columns
  EMPTY = "_" 
  SEPERATOR = "|"

  def initialize
    @rows = 6
    @columns = 7
    clear_board
  end

  def clear_board
    @positions = Array.new(@rows) { Array.new(@columns, EMPTY) }
  end

  def add_piece(column, piece)
    (@rows-1).downto(0) do |row|
      if @positions[row][column] == EMPTY
        @positions[row][column] = piece
        return true
      end
    end
    return false
  end

  def get_column(column)
    col_array = []
    @rows.times do |i|
      col_array[i] = @positions[i][column]
    end
    col_array
  end

  def to_s
    output_string = ""
    @rows.times do |row|
      output_string += row_to_s(row)
    end
    output_string + "\n"
  end

  def row_to_s(row)
    output_string = "\n#{SEPERATOR}"
    @columns.times do |column|
      output_string += @positions[row][column] + SEPERATOR
    end
    output_string
  end

end
