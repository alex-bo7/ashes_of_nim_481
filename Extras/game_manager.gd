extends Node

#region variables
enum turn {PLAYER, CPU}

var matches_arr: Array = []
var depth_lim: int = -1
# for algorithm call is_algo used for CPU turn

# current states needs to be initialized here for gui to work
var current_state: GameState = GameState.new(turn.PLAYER, 0, [], [])
var nim: GameOfNim

var selected_row: int = -1
var selected_matches: Array = []
var all_match_objects: Array = []
var move_state: Array = []

#endregion

#region StateManagement
func initialize_values() -> void:
	matches_arr = GameSettings.matches_arr
	depth_lim = GameSettings.depth_lim
	nim = GameOfNim.new(matches_arr)
	current_state = nim.initial


func player_move() -> void:
	var move = [selected_row, selected_matches.size()]
	move_state = move
	
	current_state = nim.result(current_state, move)
	manage_game_state()


func cpu_move() -> void:
	await get_tree().create_timer(0.5).timeout
	if current_state.moves.is_empty():
		return
	
	if GameSettings.is_algo_random():
		move_state = Algorithms.random_move(current_state.moves)
	elif GameSettings.is_algo_minimax():
		move_state = Algorithms.minmax_decision(current_state, nim)
	else:
		var cutoff_test = func(state, depth): return depth > depth_lim or nim.terminal_test(state)
		var eval_fn = func(state): return nim.utility(state, nim.to_move(current_state))
		move_state = Algorithms.alpha_beta_cutoff_search(current_state, nim, depth_lim, cutoff_test, eval_fn)
	
	current_state = nim.result(current_state, move_state)
	manage_game_state()


func manage_game_state() -> void:
	reset_selections()
	print_debug('GameState after move: ', move_state)
	nim.display(current_state)
	
	if nim.terminal_test(current_state):
		# check winner from players perspective
		var final_player_utility: int = nim.utility(current_state, turn.PLAYER) 
		print("Final utility for Player:", final_player_utility)
		
		current_state.utility = final_player_utility 
		
		get_tree().change_scene_to_file("res://EndGame/end_game.tscn")
		return
	
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
		# cpu doesn't select any in game items so we need to destoy objects from its computed move
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
