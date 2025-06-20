extends Node3D

const MATCH_STICK_SCENE = preload("res://MatchStick/match_stick.tscn")
const PLACEMENT_STEPS: float = 0.2

func _ready() -> void:
	place_match_sticks(GameSettings.matches_arr.size())
	GameManager.display(GameManager.current_state)


func calculate_halfs(length: int) -> Array:
	var arr_first_half: int = length / 2
	var arr_second_half: int = length - arr_first_half
	
	#print_debug('array halfs: ', arr_first_half, ', ', arr_second_half)
	return [arr_first_half, arr_second_half]


func place_match(i:int, x:float, y:float) -> void:
	var match_stick_instance = MATCH_STICK_SCENE.instantiate()
	match_stick_instance.row_idx = i
	match_stick_instance.freeze = true
	
	match_stick_instance.position = Vector3(x, y, 0)
	add_child(match_stick_instance)
	#print_debug('match: ', match_stick_instance.position)
	#print_debug('row: ', match_stick_instance.row_idx)
	GameManager.all_match_objects.append(match_stick_instance)


func place_match_sticks(amount: int) -> void:
	var steps_y: float = 0
	var steps_x: float = 0
	
	for i in range(amount):
		place_match(i, steps_x, steps_y)
		
		if GameSettings.matches_arr[i] > 1: # got to place more matches, this time horizontally
			var halfs = calculate_halfs(GameSettings.matches_arr[i])
			halfs[1] -= 1 # we subtract 1 becaue we already place 1 match
			
			for j in range(halfs[0]):
				steps_x -= PLACEMENT_STEPS
				place_match(i, steps_x, steps_y)
			steps_x = 0
			
			for k in range(halfs[1]):
				steps_x += PLACEMENT_STEPS
				place_match(i, steps_x, steps_y)
			steps_x = 0
		
		steps_y = steps_y - PLACEMENT_STEPS - 0.05
