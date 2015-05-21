output_strings = {
  :move_row_prompt => "Select row to add piece (0-6)"
}

class Connect
  attr_reader :board
  PLAYER_ONE = "X"
  def initialize(board)
    @board = board
  end

  def game_start
    show_board
  end

  def show_board
    puts @board.board_to_s
  end

private
  def get_move
    gets
  end

  def make_move(slot)

  end
end

class Connect_view
  def Connect_view.move_input
    $stdin.gets.chomp
  end
end

class Board
  attr_reader :positions
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
    @positions[-1][column] = piece
  end

  def get_column(column)
    col_array = []
    @rows.times do |i|
      col_array[i] = @positions[i][column]
    end
    col_array
  end

  def board_to_s
    output_string = ""
    @rows.times do |row|
      output_string += "\n#{SEPERATOR}"
      @columns.times do |column|
        output_string += @positions[row][column] + SEPERATOR
      end
    end
    output_string + "\n"
  end

end
