extends RigidBody3D

@export var row_idx: int = -1
@export var match_stick_black: Node3D
@export var match_stick_red: Node3D

# click select match
# click again deselect match

func select_match() -> void:
	match_stick_red.visible = true
	match_stick_black.visible = false
	GameManager.selected_matches.append(self)


func deselect_match() -> void:
	match_stick_red.visible = false
	match_stick_black.visible = true
	GameManager.selected_matches.erase(self)


func on_click() -> void:
	if (self in GameManager.selected_matches):
		deselect_match()
	elif GameManager.current_selected_row == -1 or GameManager.selected_matches.size() == 0:
		GameManager.current_selected_row = row_idx
		select_match()
	elif GameManager.current_selected_row == row_idx:
		select_match()
	else:
		print("Must select matches in current row: ", row_idx)
