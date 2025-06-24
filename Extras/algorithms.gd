extends Node


func random_move(moves: Array) -> Array:
	var move_index: int = randi_range(0, moves.size() - 1)
	return moves[move_index]

# ----- from aimacode repo (modified to work in gdscript) -----
func alpha_beta_cutoff_search(state: GameState, game:GameOfNim, d:int, cutoff_test: Callable, eval_fn: Callable):
	var player = game.to_move(state)

	if cutoff_test == null:
		cutoff_test = func(state, depth): return depth > d or game.terminal_test(state)
	if eval_fn == null:
		eval_fn = func(state): return game.utility(state, player)

	var best_score = -INF
	var beta = INF
	var best_action = null

	for a in game.actions(state):
		var v = ab_min_value(game.result(state, a), game, cutoff_test, eval_fn, best_score, beta, 1)
		if v > best_score:
			best_score = v
			best_action = a

	return best_action

# alpha_beta_cutoff_search inside functions
func ab_max_value(state, game, cutoff_test, eval_fn, alpha, beta, depth):
	if cutoff_test.call(state, depth):
		return eval_fn.call(state)
	var v = -INF
	for a in game.actions(state):
		v = max(v, ab_min_value(game.result(state, a), game, cutoff_test, eval_fn, alpha, beta, depth + 1))
		if v >= beta:
			return v
		alpha = max(alpha, v)
	return v

func ab_min_value(state, game, cutoff_test, eval_fn, alpha, beta, depth):
	if cutoff_test.call(state, depth):
		return eval_fn.call(state)
	var v = INF
	for a in game.actions(state):
		v = min(v, ab_max_value(game.result(state, a), game, cutoff_test, eval_fn, alpha, beta, depth + 1))
		if v <= alpha:
			return v
		beta = min(beta, v)
	return v


var _game_ref:GameOfNim = null # A reference to the game object

func minmax_decision(state:GameState, game:GameOfNim):
	"""Given a state in a game, calculate the best move by searching
	forward all the way to the terminal states."""

	_game_ref = game # Store a reference to the game object
	var player = game.to_move(state)

	var best_action = null
	var best_value = -INF

	for a in game.actions(state):
		var action_value = mm_min_value(game.result(state, a), player, game)
		if action_value > best_value:
			best_value = action_value
			best_action = a
	return best_action


func mm_max_value(current_state, player_to_optimize_for, game):
	if _game_ref.terminal_test(current_state):
		return _game_ref.utility(current_state, player_to_optimize_for)
	var v = -INF
	for a in _game_ref.actions(current_state):
		v = max(v, mm_min_value(game.result(current_state, a), player_to_optimize_for, game))
	return v


func mm_min_value(current_state, player_to_optimize_for, game):
	if _game_ref.terminal_test(current_state):
		return _game_ref.utility(current_state, player_to_optimize_for)
	var v = INF
	for a in _game_ref.actions(current_state):
		v = min(v, mm_max_value(game.result(current_state, a), player_to_optimize_for, game))
	return v
