extends Node

#region variables
enum turn {PLAYER, CPU}

var matches_arr: Array = GameSettings.matches_arr
var depth_lim: int = GameSettings.depth_lim
# for algorithm call is_algo used for CPU turn

var current_selected_row: int = -1
var selected_matches: Array = []

var current_state: GameState = GameState.new(turn.PLAYER, 0, matches_arr, generate_moves(matches_arr))
#endregion

#region GameOfNimFunc
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
	
	var new_player = turn.CPU if state.to_move == turn.PLAYER else turn.PLAYER
	var new_board = state.board.duplicate()
	new_board[move[0]] -= move[1]
	var new_moves = generate_moves(new_board)
	var new_utility = utility(new_player, new_board)
	
	return GameState.new(new_player, new_utility, new_board, new_moves)


func utility(state:GameState, player:String) -> int:
	"""Return the value to player; 1 for win, -1 for loss, 0 otherwise."""
	if self.terminal_test(state):
		var winner = turn.CPU if state.to_move == turn.PLAYER else turn.PLAYER
		return -1 if player == winner else 1
	return 0


func terminal_test(state:GameState) -> bool:
	"""A state is terminal if there are no objects left"""
	for row in state.board:
		if row != 0:
			return false
	return true


func get_moves():
	print(current_state.to_move == turn.CPU)
	#print(matches_arr)
	#print(generate_moves(matches_arr))
#endregion
