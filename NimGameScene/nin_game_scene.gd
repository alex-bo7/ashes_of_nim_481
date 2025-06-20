extends Node3D

const MATCH_STICK_SCENE = preload("res://MatchStick/match_stick.tscn")
const PLACEMENT_STEPS: float = 0.2

func _ready() -> void:
	# cut arr length in half	
	var vertical_halfs: Array = calculate_halfs(GameSettings.matches_arr.size())
	
	place_match_sticks(vertical_halfs[0], true, 1)
	place_match_sticks(vertical_halfs[1], true, -1)


func calculate_halfs(length: int) -> Array:
	var arr_first_half: int = length / 2
	var arr_second_half: int = length - arr_first_half
	
	print_debug('array halfs: ', arr_first_half, ', ', arr_second_half)
	return [arr_first_half, arr_second_half]
	
# the first one place += 0.1 then PLACEMENT STEPS
func place_match_sticks(amount: int, is_vertical: bool, direction: int) -> void:
	var step: float = PLACEMENT_STEPS
	for i in range(amount):
		var match_stick_instance = MATCH_STICK_SCENE.instantiate()
		match_stick_instance.row_idx = i
		match_stick_instance.freeze = true
		
		if is_vertical:
			match_stick_instance.position = Vector3(0, step * direction, 0)
		add_child(match_stick_instance)
		
		step += PLACEMENT_STEPS
