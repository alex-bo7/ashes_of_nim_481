extends Node


func random_move(moves: Array) -> Array:
	var move_index: int = randi_range(0, moves.size() - 1)
	return moves[move_index]

# from aimacode repo (modified to work in gdscript)
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
		var v = min_value(game.result(state, a), game, cutoff_test, eval_fn, best_score, beta, 1)
		if v > best_score:
			best_score = v
			best_action = a

	return best_action

# alpha_beta_cutoff_search inside functions
func max_value(state, game, cutoff_test, eval_fn, alpha, beta, depth):
	if cutoff_test.call(state, depth):
		return eval_fn.call(state)
	var v = -INF
	for a in game.actions(state):
		v = max(v, min_value(game.result(state, a), game, cutoff_test, eval_fn, alpha, beta, depth + 1))
		if v >= beta:
			return v
		alpha = max(alpha, v)
	return v

func min_value(state, game, cutoff_test, eval_fn, alpha, beta, depth):
	if cutoff_test.call(state, depth):
		return eval_fn.call(state)
	var v = INF
	for a in game.actions(state):
		v = min(v, max_value(game.result(state, a), game, cutoff_test, eval_fn, alpha, beta, depth + 1))
		if v <= alpha:
			return v
		beta = min(beta, v)
	return v
