require "./connect_four"
require "stringio"

describe "connect_four" do
  let(:empyt_slot) { Board::SEPERATOR + Board::EMPTY }
  let(:empty_row)  { (empyt_slot) * 7 + Board::SEPERATOR + "\n" }
  let(:empty_board){ "\n" + empty_row * 6 } 
  let(:output)     { double('output').as_null_object }
  let(:input)      { double('input').as_null_object  }
  let(:board)      { Board.new }
  let(:game)       { Connect.new(board, output) }
  let(:move_row)      { Board::SEPERATOR + Connect::PLAYER_ONE + empyt_slot * 6 + "|" + "\n"}
  let(:one_move_at_0) { "\n" + empty_row * 5 + move_row }
  let(:two_moves_at_0){ "\n" + empty_row * 4 + move_row * 2 }
  let(:vertical_win)  { Array.new(6){ [Connect::PLAYER_ONE] + [Board::EMPTY]*6 } }
  let(:horizontal_win){ Array.new(6){ Array.new(7,Connect::PLAYER_ONE) } }

  def add_piece_at_0
     board.add_piece(0, Connect::PLAYER_ONE)
  end

  describe "starts a new game" do
    it "prints a 6 row 7 column board" do
      expect(output).to receive(:puts).with(empty_board)
      game.game_start
    end
    it "askes player one for thier move" do
      expect(output).to receive(:puts).with("Player one, enter column (0-6) to add peice: ")
      game.game_start
    end
  end

  describe "making a move" do
    let(:move_row)       { Board::SEPERATOR + Connect::PLAYER_ONE + empyt_slot * 6 }
    let(:move_on_board)  { empty_row * 5 + move_row }

    it "allows the player to input a move" do
      allow(input).to receive(:gets){ "1" }
      expect(Connect_view.move_input(input)).to eql "1"
      $stdin = STDIN
    end

    it "stores a move" do
      board.add_piece(1, Connect::PLAYER_ONE)
      expect(board.get_column(1)[-1]).to eql Connect::PLAYER_ONE
    end
  end

  describe "Ending the game" do
    let(:full_board)     { Array.new(6) { Array.new(7, Connect::PLAYER_ONE) }}
    let(:board_double)   { double('board', :positions => horizontal_win, :rows => 6, :columns =>7) }
    let(:board_double_full){ double('board', :positions => full_board, :rows => 6, :columns =>7) }
    let(:game_win)       { Connect.new(board_double) }
    let(:game_stalemate) { Connect.new(board_double_full) }
    let(:diagonal_win)  { [ ["X","_","_","_","_","_","_"],
                            ["_","X","_","_","_","_","_"],
                            ["_","_","X","_","_","_","_"],
                            ["_","_","_","X","_","_","_"],
                            ["_","_","_","_","_","_","_"],
                            ["_","_","_","_","_","_","_"]]
    }
    let(:diagonal_board)   { double('board', :positions => diagonal_win, :rows => 6, :columns =>7) }
    let(:game_diagonal_win){ Connect.new(diagonal_board) }

    it "detects no win on empty board" do
      expect(game.player_won).to eql false
    end
    it "detects a vertical win" do
      expect(game_win.player_won).to eql Connect::PLAYER_ONE
    end
    it "detects a horizontal_win" do
      expect(game_win.player_won).to eql Connect::PLAYER_ONE
    end
    it "detects a diagonal win" do
      expect(game_diagonal_win.player_won).to eql Connect::PLAYER_ONE
    end
    it "detects a full board" do
      expect(game_stalemate.board_full?).to equal true
    end

  end

  describe Board do
    describe "adding pieces on the board" do

      it "displays a moves at position 0 after adding piece at 0" do
        add_piece_at_0
        expect(board.to_s).to eql one_move_at_0
      end
      it "displays 2 moves at position 0 after adding two peices at 0" do
        2.times { add_piece_at_0 }
        expect(board.to_s).to eql two_moves_at_0
      end
      it "returns false if row is full" do
        (board.rows).times { add_piece_at_0 }
        expect(add_piece_at_0).to equal false
      end
    end
  end

end
