extends RefCounted

var matches_arr: Array = [1, 3, 5]

enum Algorithm { MINIMAX, RANDOM }
var current_algorithm: Algorithm = Algorithm.MINIMAX

var depth_lim: int = 3

func is_algo_minimax() -> bool:
	return current_algorithm == Algorithm.MINIMAX


func set_algo_as_minimax() -> void:
	current_algorithm = Algorithm.MINIMAX


func set_algo_as_random() -> void:
	current_algorithm = Algorithm.RANDOM
