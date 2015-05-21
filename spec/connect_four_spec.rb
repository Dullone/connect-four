require "./connect_four"
require "stringio"

describe "connect_four" do
  let(:empyt_slot) { Board::SEPERATOR + Board::EMPTY }
  let(:empty_row) { (empyt_slot) * 7 + Board::SEPERATOR + "\n" }
  let(:empty_board){ "\n" + empty_row * 6 } 
  let(:game){ Connect.new(Board.new) }
  describe "starts a new game" do
    it "prints a 6 row 7 column board" do
      expect{ game.game_start }.to output(/^#{empty_board}.*/).to_stdout
    end
  end

  describe "making a move" do
    let(:move_row)    { Board::SEPERATOR + Connect::PLAYER_ONE + empyt_slot * 6 }
    let(:move_board)  { empty_row * 5 + move_row }
    let(:board)       { Board.new }
    it "allows the player to input a move" do
      $stdin = StringIO.new("1\n")
      expect(Connect_view.move_input).to eql "1"
      $stdin = STDIN
    end
    it "stores a move" do
      board.add_piece(1, Connect::PLAYER_ONE)
      expect(board.get_column(1)[-1]).to eql Connect::PLAYER_ONE
    end
  end
end