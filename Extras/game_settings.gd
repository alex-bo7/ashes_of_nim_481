extends Node

var matches_arr: Array = [1, 3, 5]

enum Algorithm { ALPHABETA, RANDOM }
var current_algorithm: Algorithm = Algorithm.ALPHABETA

var depth_lim: int = 3

func is_algo_alphabeta() -> bool:
	return current_algorithm == Algorithm.ALPHABETA


func set_algo_as_alphabeta() -> void:
	current_algorithm = Algorithm.ALPHABETA


func set_algo_as_random() -> void:
	current_algorithm = Algorithm.RANDOM
