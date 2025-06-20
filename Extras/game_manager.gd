extends Node

# copy settings from GameSettings
# handle match selection
# make code work with project 2 code
# handle player turn?
enum turn {PLAYER, CPU}
var current_turn: turn = turn.PLAYER # player plays first


var matches_arr: Array = GameSettings.matches_arr
var depth_lim: int = GameSettings.depth_lim
# for algorithm call is_algo

var current_selected_row: int = -1
var selected_matches: Array = []
