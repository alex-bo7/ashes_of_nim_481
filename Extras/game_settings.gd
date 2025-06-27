extends Node

var matches_arr: Array = [1, 3, 5]

enum Algorithm { RANDOM, MINIMAX, ALPHABETA }
var current_algorithm: Algorithm = Algorithm.RANDOM

var depth_lim: int = 1

func is_algo_random() -> bool:
	return current_algorithm == Algorithm.RANDOM


func is_algo_minimax() -> bool:
	return current_algorithm == Algorithm.MINIMAX


func get_algo() -> Algorithm:
	return current_algorithm


func set_algo_as_random() -> void:
	current_algorithm = Algorithm.RANDOM


func set_algo_as_minimax() -> void:
	current_algorithm = Algorithm.MINIMAX


func set_algo_as_alphabeta() -> void:
	current_algorithm = Algorithm.ALPHABETA
