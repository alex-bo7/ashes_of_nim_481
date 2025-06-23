extends Control

@export var rows: LineEdit
@export var depth_limit: LineEdit
@export var minimax_btn: Button
@export var random_btn: Button

const MIN_DEPTH = 3
const MAX_DEPTH = 20

const EASY: String = 'easy'
const MEDIUM: String = 'medium'
const HARD: String = 'hard'

const DIFFICULTY_VALUES: Dictionary = {
	EASY: {"min_rows": 2, "max_rows": 3, "min_val": 1, "max_val": 4},
	MEDIUM: {"min_rows": 3, "max_rows": 4, "min_val": 2, "max_val": 6},
	HARD: {"min_rows": 3, "max_rows": 5, "min_val": 3, "max_val": 9},
}

# ---------- Godot ----------
func _ready() -> void:
	randomize() # seed is randomized every time scene is loaded
	
	rows.text = str(GameSettings.matches_arr)
	depth_limit.text = str(GameSettings.depth_lim)
	
	minimax_btn.button_pressed = GameSettings.is_algo_alphabeta()
	random_btn.button_pressed = !GameSettings.is_algo_alphabeta()

#region Helper
func generate_array(arr_length:int, min_val:int, max_val:int) -> Array:
	var arr_result: Array = []
	for i in range(arr_length):
		var random_int: int = randi_range(min_val, max_val)
		arr_result.append(random_int)
	return arr_result


func generate_rows(min_size:int, max_size:int, min_value:int, max_value:int) -> Array:
	# generate random array size
	var arr_size: int = randi_range(min_size, max_size)
	# fill array with random numbers
	var arr: Array = generate_array(arr_size, min_value, max_value)
	# debug
	print_debug('Array: ', arr)
	return arr


func calculate_depth_limit(arr: Array, difficulty: String) -> int:
	# count total matches in all of the rows
	var total: int = 0
	for row in arr:
		total += row
	
	'''
		Depth limit formula by ChatGPT
	
		Base depth using log₂(n)
		How many times you can divide a number in half until you get to 1
	'''
	var base_depth: float = log(total + 1) / log(2)

	# Apply difficulty-based buffer
	var buffer: float = 0.0
	if difficulty == EASY:
		buffer = 1.0
	elif difficulty == MEDIUM:
		buffer = 3.0
	else:
		buffer = 5.0
	var depth: int = int(base_depth + buffer)

	# Clamp to prevent overload / make sure number is not too small or too big
	var depth_limit_result: int = clamp(depth, MIN_DEPTH, MAX_DEPTH)
	print_debug('Depth limit: ', depth_limit_result)
	return depth_limit_result


func handle_difficulty(difficulty: String) -> void:
	var values = DIFFICULTY_VALUES[difficulty]
	
	var arr: Array = generate_rows(
		values['min_rows'],
		values['max_rows'],
		values['min_val'],
		values['max_val']
	)
	GameSettings.matches_arr = arr
	rows.text = str(arr)
	
	var limit: int = calculate_depth_limit(arr, difficulty)
	GameSettings.depth_lim = limit
	depth_limit.text = str(limit)
#endregion


#region Godot:Button Signals
func _on_back_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://MainMenu/main_menu.tscn")


func _on_easy_btn_pressed() -> void:
	handle_difficulty(EASY)


func _on_medium_btn_pressed() -> void:
	handle_difficulty(MEDIUM)


func _on_hard_btn_pressed() -> void:
	handle_difficulty(HARD)


func _on_minimax_select_pressed() -> void:
	GameSettings.set_algo_as_alphabeta()


func _on_random_select_pressed() -> void:
	GameSettings.set_algo_as_random()
#endregion
