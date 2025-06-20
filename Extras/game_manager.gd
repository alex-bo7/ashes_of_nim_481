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
	var new_state = GameState.new(new_player, 0, new_board, new_moves)
	
	var new_utility = utility(new_state, new_player)
	return GameState.new(new_player, new_utility, new_board, new_moves)


func utility(state:GameState, player:turn) -> int:
	"""Return the value to player; 1 for win, -1 for loss, 0 otherwise."""
	if terminal_test(state):
		var winner = turn.CPU if state.to_move == turn.PLAYER else turn.PLAYER
		return -1 if player == winner else 1
	return 0


func terminal_test(state:GameState) -> bool:
	"""A state is terminal if there are no objects left"""
	for row in state.board:
		if row != 0:
			return false
	return true


func display(state:GameState) -> void:
	print_debug("Turn: ", state.to_move, "\nUtility: ", state.utility, 
	"\nBoard: ", state.board, "\nMoves: ", state.moves)


func player_move() -> void:
	var move = [current_selected_row, selected_matches.size()]
	print("Player move: ", move)
	
	current_state = result(current_state, move)
	manage_game_state()


func cpu_move() -> void:
	var move = randi_range(0, current_state.moves.size())
	move = current_state.moves[move]
	print("CPU move: ", move)
	
	current_state = result(current_state, move)
	manage_game_state()


func manage_game_state() -> void:
	display(current_state)
	# TODO: reset row, matches and delete matches
	
	# check winner
	if terminal_test(current_state):
		if current_state.to_move == turn.PLAYER:
			print("CPU Won")
		else:
			print("PLAYER Won")
		return # game over
	
	# run next move
	if current_state.to_move == turn.CPU:
		await get_tree().create_timer(0.5).timeout
		cpu_move()
	# else player_move() called when player presses confirm btn
#endregion
