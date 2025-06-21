extends Node

#region variables
enum turn {PLAYER, CPU}

var matches_arr: Array = []
var depth_lim: int = -1
# for algorithm call is_algo used for CPU turn

# current states needs to be initialized here for gui to work
var current_state: GameState = GameState.new(turn.PLAYER, 0, [], [])


var selected_row: int = -1
var selected_matches: Array = []
var all_match_objects: Array = []
var move_state: Array = []

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

#endregion

#region StateManagement
func initialize_values() -> void:
	matches_arr = GameSettings.matches_arr
	depth_lim = GameSettings.depth_lim
	current_state = GameState.new(turn.PLAYER, 0, matches_arr, generate_moves(matches_arr))


func player_move() -> void:
	var move = [selected_row, selected_matches.size()]
	move_state = move
	
	current_state = result(current_state, move)
	manage_game_state()


func cpu_move() -> void:
	await get_tree().create_timer(0.5).timeout

	# TODO replace with algorithm form 481
	var move_index = randi_range(0, current_state.moves.size() - 1)
	var move = current_state.moves[move_index]
	move_state = move
	
	current_state = result(current_state, move)
	manage_game_state()


func manage_game_state() -> void:
	reset_selections()
	print_debug('GameState after move: ', move_state)
	display(current_state)
	
	# check winner
	if terminal_test(current_state):
		if current_state.to_move == turn.PLAYER:
			print("CPU Won")
		else:
			print("PLAYER Won")
		return # game over
	
	# run next move
	if current_state.to_move == turn.CPU:
		cpu_move()
	# else player_move() called when player presses confirm btn


func reset_selections() -> void:
	selected_row = -1
	
	if current_state.to_move == turn.CPU:
		for match_stick in selected_matches:
			match_stick.queue_free()
			all_match_objects.erase(match_stick)
	else:
		# cpu doesn't select any in game items so
		# we need to destoy objects from its generated move
		var to_destroy: Array = []
		for match_stick in all_match_objects:
			if match_stick.row_idx == move_state[0] and move_state[1] != 0:
				to_destroy.append(match_stick)
				move_state[1] -= 1
		
		for match_stick in to_destroy:
			match_stick.queue_free()
			all_match_objects.erase(match_stick)
	selected_matches.clear()

#endregion
