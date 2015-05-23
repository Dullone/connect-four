require "./connect_four"

board = Board.new()
game = Connect.new(board)
turn = "X"
while !game.player_won do
	print "Player #{turn}, enter column (0-6) to add peice: "
	board.add_piece Connect_view.move_input(STDIN).to_i, turn
	print board.to_s
	if turn == "X"
		turn = "O"
	else
		turn = "X"
	end
end