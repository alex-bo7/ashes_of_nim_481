extends Control

@export var rows: LineEdit
@export var random_btn: Button
@export var minimax_btn: Button
@export var alphabeta_btn: Button
@export var depth_limit: LineEdit
@export var record_info: RichTextLabel

const MIN_DEPTH = 3
const MAX_DEPTH = 20

const EASY: String = 'easy'
const MEDIUM: String = 'medium'
const HARD: String = 'hard'

const DIFFICULTY_VALUES: Dictionary = {
	EASY: {"min_rows": 2, "max_rows": 3, "min_items": 1, "max_items": 5},
	MEDIUM: {"min_rows": 3, "max_rows": 4, "min_items": 1, "max_items": 8},
	HARD: {"min_rows": 4, "max_rows": 6, "min_items": 1, "max_items": 15},
}

# ---------- Godot ----------
func _ready() -> void:
	randomize() # seed is randomized every time scene is loaded
	
	rows.text = str(GameSettings.matches_arr)
	depth_limit.text = str(GameSettings.depth_lim)
	
	set_selected_btn()
	fill_records()

#region Helper
func fill_records() -> void:
	if Records.games_played == 0:
		record_info.text = "No games played yet"
	else:
		record_info.text = "Games played: " + str(Records.games_played) + \
		"\nPlayer wins: " + str(Records.player_wins) + \
		"\n CPU wins: " + str(Records.games_played - Records.player_wins)


func set_selected_btn() -> void:
	random_btn.button_pressed = GameSettings.get_algo() == GameSettings.Algorithm.RANDOM
	minimax_btn.button_pressed = GameSettings.get_algo() == GameSettings.Algorithm.MINIMAX
	alphabeta_btn.button_pressed = GameSettings.get_algo() == GameSettings.Algorithm.ALPHABETA


func generate_array(arr_length:int, min_items:int, max_items:int) -> Array:
	var arr_result: Array = []
	for i in range(arr_length):
		var random_int: int = randi_range(min_items, max_items)
		arr_result.append(random_int)
	return arr_result


func generate_rows(min_size:int, max_size:int, min_itemsue:int, max_itemsue:int) -> Array:
	# generate random array size
	var arr_size: int = randi_range(min_size, max_size)
	# fill array with random numbers
	var arr: Array = generate_array(arr_size, min_itemsue, max_itemsue)
	# debug
	print_debug('Array: ', arr)
	return arr


func calculate_depth_limit(arr: Array, difficulty: String) -> int:
	if difficulty == EASY:
		return randi_range(0, 1)
	return 2


func handle_difficulty(difficulty: String) -> void:
	var values = DIFFICULTY_VALUES[difficulty]
	
	var arr: Array = generate_rows(
		values['min_rows'],
		values['max_rows'],
		values['min_items'],
		values['max_items']
	)
	GameSettings.matches_arr = arr
	rows.text = str(arr)
	
	var limit: int = calculate_depth_limit(arr, difficulty)
	GameSettings.depth_lim = limit
	depth_limit.text = str(limit)
#endregion


func _on_rows_input_text_changed(new_text: String) -> void:
	GameSettings.matches_arr.clear()
	for letter in new_text.split(",", false):
		var number: int = letter.to_int()
		if number > 0:
			GameSettings.matches_arr.append(number)


func _on_limit_input_text_changed(new_text: String) -> void:
	GameSettings.depth_lim = new_text.to_int()
	_on_alphabeta_select_pressed()


#region Godot:Button Signals
func _on_back_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://MainMenu/main_menu.tscn")


func _on_easy_btn_pressed() -> void:
	handle_difficulty(EASY)


func _on_medium_btn_pressed() -> void:
	handle_difficulty(MEDIUM)


func _on_hard_btn_pressed() -> void:
	handle_difficulty(HARD)


func _on_random_select_pressed() -> void:
	GameSettings.set_algo_as_random()


func _on_minimax_select_pressed() -> void:
	GameSettings.set_algo_as_minimax()


func _on_alphabeta_select_pressed() -> void:
	GameSettings.set_algo_as_alphabeta()
#endregion
