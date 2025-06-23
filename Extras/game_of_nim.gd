extends RefCounted
class_name GameOfNim

var board: Array
var initial: GameState

func _init(board: Array):
	self.board = board
	var moves = self.generate_moves(board)
	self.initial = GameState.new(GameManager.turn.PLAYER, 0, board, moves)


func generate_moves(board: Array) -> Array:
	var moves = []
	for i in range(board.size()):
		if board[i] == 0:
			continue
		else:
			for j in range(0, board[i]):
				moves.append([i, j + 1])
	return moves # returns array of arrays i.e [ [0, 1], [1, 1] ]


func actions(state: GameState) -> Array:
	"""Legal moves are at least one object, all from the same row."""
	return state.moves


func result(state:GameState, move:Array) -> GameState:
	if move not in state.moves:
			return state  # Illegal move has no effect 
	
	var new_player = GameManager.turn.CPU if state.to_move == GameManager.turn.PLAYER else GameManager.turn.PLAYER
	var new_board = state.board.duplicate()
	new_board[move[0]] -= move[1]
	var new_moves = generate_moves(new_board)
	var new_state = GameState.new(new_player, 0, new_board, new_moves)
	
	var new_utility = utility(new_state, new_player)
	return GameState.new(new_player, new_utility, new_board, new_moves)


func utility(state:GameState, player) -> int:
	"""Return the value to player; 1 for win, -1 for loss, 0 otherwise."""
	if terminal_test(state):
		var winner = GameManager.turn.CPU if state.to_move == GameManager.turn.PLAYER else GameManager.turn.PLAYER
		return -1 if player == winner else 1
	return 0


func terminal_test(state:GameState) -> bool:
	"""A state is terminal if there are no objects left"""
	for row in state.board:
		if row != 0:
			return false
	return true


func display(state:GameState) -> void:
	print("Turn: ", state.to_move, "\nUtility: ", state.utility, 
	"\nBoard: ", state.board, "\nMoves: ", state.moves)
